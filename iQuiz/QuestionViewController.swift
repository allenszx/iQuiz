//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by applemac on 11/4/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
  
  var selectQuestion: Question?
  var questions : [Question] = []
  var currentSelect = 0
  var correctNumber = 0
  
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var optionA: UIButton!
  @IBOutlet weak var optionB: UIButton!
  @IBOutlet weak var optionC: UIButton!
  @IBOutlet weak var optionD: UIButton!
  
  @IBAction func answerClick(_ sender: UIButton) {
    currentSelect = sender.tag
    optionA.backgroundColor = UIColor.white
    optionB.backgroundColor = UIColor.white
    optionC.backgroundColor = UIColor.white
    optionD.backgroundColor = UIColor.white
    sender.backgroundColor = UIColor.orange
  }
  @IBAction func verify(_ sender: UIButton) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toAnswer" {
      let answerVC = segue.destination as! AnswerViewController
      answerVC.isCorrect = currentSelect ==  selectQuestion?.correctAnswer
      answerVC.correctAnswer = (selectQuestion?.answers[(selectQuestion?.correctAnswer)!])!
      answerVC.question = (selectQuestion?.question)!
      answerVC.questions = questions
      answerVC.correctNumber = correctNumber
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    selectQuestion = questions.removeFirst()
    questionLabel.text = selectQuestion!.question
    optionA.setTitle(selectQuestion!.answers[0], for: .normal)
    optionB.setTitle(selectQuestion!.answers[1], for: .normal)
    optionC.setTitle(selectQuestion!.answers[2], for: .normal)
    optionD.setTitle(selectQuestion!.answers[3], for: .normal)
    
  }
}
