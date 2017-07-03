//
//  ViewController.swift
//  week1_book_ch1_Quiz
//
//  Created by LEOFALCON on 2017. 7. 3..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel : UILabel!
    
    let questions : [String] = ["From what is cognac made",
                               "What is 7+7",
                               "What is the capital of Vermont"]
    let answers : [String] = ["Grapes","14","Montpelier"]
    var currentQuestionIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]

    }
    
    @IBAction func showNextQuestion(sender : AnyObject){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    @IBAction func showAnswer(sender : AnyObject){
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }

}

