//
//  ViewController.swift
//  iQuiz
//
//  Created by applemac on 10/29/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit

struct Question {
  var text : String
  var answer : String
  var answers : [String]
  init(json: [String : Any]) {
    text = json["text"] as! String
    answer = json["answer"] as! String
    answers = json["answers"] as! [String]
  }
}

struct Course {
  var title : String
  var desc : String
  var questions : [Question]
  init(json: [String : Any]) {
    title = json["title"] as! String
    desc = json["desc"] as! String
    questions = []
    let jsonQuestions = json["questions"] as! [Any]
    for question in jsonQuestions {
      questions.append(Question(json: question as! [String : Any]))
    }
  }
}

class customCell : UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var img: UIImageView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var currentQuestions : [Question] = []
  var url = "http://tednewardsandbox.site44.com/questions.json"
  var courses : [Course] = []
  var localFile = "local.txt"
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
    cell.title?.text = courses[indexPath.row].title
    cell.desc?.text = courses[indexPath.row].desc
    cell.img?.image = UIImage(named: "myicon")
    return cell
  }

  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  @IBAction func setting(_ sender: UIBarButtonItem) {
    let uiAlert = UIAlertController(title: nil, message: "Get data from url", preferredStyle: .alert)
    uiAlert.addTextField()
    uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak uiAlert] (_) in
      self.url = uiAlert!.textFields![0].text!
      self.loadData()
    }))
    self.present(uiAlert, animated: true, completion: nil)
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
    
    // Do any additional setup after loading the view, typically from a nib.
   
  }
  
  
  func loadData() {
    guard let dataUrl = URL(string: url) else {
      return
    }
    
    URLSession.shared.dataTask(with: dataUrl) { (data, response, err) in
      guard let data = data else {return}
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        if let jsonCourses = json as? [Any] {
          for course in jsonCourses {
            self.courses.append(Course(json: course as! [String : Any]))
            DispatchQueue.main.async {
              self.tableView.delegate = self
              self.tableView.dataSource = self
            }
          }
        }
        
        let string = String(data: data, encoding: .utf8)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
          let fileURL = dir.appendingPathComponent(self.localFile)
          do {
            try string?.write(to: fileURL, atomically: false, encoding: .utf8)
          } catch {
            
            print("Data write error!")
          }
        }
        
        
      } catch let err {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
          let fileURL = dir.appendingPathComponent(self.localFile)
          do {
            let localData = try String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8)
            let localJson = try JSONSerialization.jsonObject(with: localData!, options: .mutableContainers)
            if let jsonCourses = localJson as? [Any] {
              for course in jsonCourses {
                self.courses.append(Course(json: course as! [String : Any]))
                DispatchQueue.main.async {
                  self.tableView.delegate = self
                  self.tableView.dataSource = self
                }
              }
            }
          } catch {
            print("Data read error!")
          }
        }
        
        print(err)
      }
    }.resume()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    currentQuestions = courses[indexPath.row].questions
    performSegue(withIdentifier: "toQuestion", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toQuestion"  {
      let questionVC = segue.destination as! QuestionViewController
      questionVC.questions = currentQuestions
      questionVC.totalNumber = currentQuestions.count
    }
  }
}

