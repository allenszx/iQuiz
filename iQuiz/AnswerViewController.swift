//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by applemac on 11/5/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var result: UILabel!
  @IBOutlet weak var response: UILabel!
  var questions : [Question] = []
  var question = ""
  var isCorrect = false
  var correctAnswer = ""
  var correctNumber = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    if !isCorrect {
      response.text = "This is wrong."
    }else{
      correctNumber += 1
    }
    result.text = correctAnswer
    questionLabel.text = question
  }
  @IBAction func nextClick(_ sender: Any) {
    if questions.count == 0 {
      performSegue(withIdentifier: "toFinish", sender: self)
    } else {
      performSegue(withIdentifier: "backQuestion", sender: self)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toFinish" {
      let finishVC = segue.destination as! FinishViewController
      finishVC.correctNumber = correctNumber
    } else if segue.identifier == "backQuestion" {
      let questionVC = segue.destination as! QuestionViewController
      questionVC.questions = questions
      questionVC.correctNumber = correctNumber
    }
  }
}
