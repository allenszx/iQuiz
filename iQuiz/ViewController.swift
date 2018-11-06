//
//  ViewController.swift
//  iQuiz
//
//  Created by applemac on 10/29/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit

struct Question {
  var question: String
  var answers: [String]
  var correctAnswer: Int
}

class customCell : UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var img: UIImageView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var currentQuestions : [Question] = []
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
    cell.title?.text = titles[indexPath.row]
    cell.desc?.text = desc[indexPath.row]
    cell.img?.image = UIImage(named: img[indexPath.row])
    return cell
  }

  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  @IBAction func setting(_ sender: UIBarButtonItem) {
    let uiAlert = UIAlertController(title: nil, message: "Check back for settings!", preferredStyle: .alert)
    uiAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(uiAlert, animated: true, completion: nil)
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.delegate = self
    tableView.dataSource = self
  }
  let titles = ["Math", "Physics", "Biology"]
  let desc = ["Math", "Physics", "Biology"]
  let img = ["Math", "Physics", "Biology"]
  
  
  
  let mathQuestion = [
    Question(question: "What is 20 percent off of 30 dollars?", answers: ["6 dollars","24 dollars","16 dollars","8 dollars"], correctAnswer: 1),
    Question(question: "What is the square root of 4?", answers: ["4","3","2","1"], correctAnswer: 2)
  ]
  let physicsQuestion = [
    Question(question: "What substance do you expect to \n have the highest specific heat?", answers: ["sulfuric acid","Iron","Silicon","Water"], correctAnswer: 3),
    Question(question: "The amount of work done \n by two boys who each apply \n 400 N of force is an unsuccessful \n attempt to move stalled car is", answers: ["0","1","2","3"], correctAnswer: 0)
  ]
  let biologyQuestion = [
    Question(question: "What regional factors can exacerbate \n acidification caused by global \n CO2 emissions?", answers: ["Subduction movement","Coastal upwelling","Winter phytoplankton blooms","Recreational fisheries "], correctAnswer: 1),
    Question(question: "Oysters growing in water with relatively \n high concentration of CO2:", answers: ["Grow faster and have are symmetrical","Grow slower and are deformed ","Grow faster and are deformed "," Grow faster and generally have more meat "], correctAnswer: 1)
  ]
  
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      currentQuestions = mathQuestion
    case 1:
      currentQuestions = physicsQuestion
    default:
      currentQuestions = biologyQuestion
    }
    
    performSegue(withIdentifier: "toQuestion", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toQuestion"  {
      let questionVC = segue.destination as! QuestionViewController
      questionVC.questions = currentQuestions
    }
  }
}

