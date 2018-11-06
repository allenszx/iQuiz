//
//  FinishViewController.swift
//  iQuiz
//
//  Created by applemac on 11/5/18.
//  Copyright © 2018 AllenShi. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
  var correctNumber = 0
  @IBOutlet weak var result: UILabel!
  @IBOutlet weak var endDesc: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    result.text = "\(correctNumber) of 2 correct"
    if correctNumber != 2 {
      endDesc.text = "Almost!"
    }
  }
}
