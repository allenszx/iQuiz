//
//  ViewController.swift
//  iQuiz
//
//  Created by applemac on 10/29/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit

class customCell : UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var desc: UILabel!
  @IBOutlet weak var img: UIImageView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
 
  
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
  let titles = ["Math", "Physics", "Biology", "Chemistry"]
  let desc = ["Math", "Physics", "Biology", "Chemistry"]
  let img = ["Math", "Physics", "Biology", "Chemistry"]
}

