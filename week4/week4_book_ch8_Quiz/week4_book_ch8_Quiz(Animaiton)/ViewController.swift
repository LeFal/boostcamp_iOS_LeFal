//
//  ViewController.swift
//  week1_book_ch1_Quiz
//
//  Created by LEOFALCON on 2017. 7. 3..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel : UILabel!
    
    let questions : [String] = ["From what is cognac made",
                               "What is 7+7",
                               "What is the capital of Vermont"]
    let answers : [String] = ["Grapes","14","Montpelier"]
    var currentQuestionIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
    }
    
    @IBAction func showNextQuestion(sender : AnyObject){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitons()
    }
    
    
    @IBAction func showAnswer(sender : AnyObject){
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitons() {
        self.view.layoutIfNeeded()

        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth

        
        UIView.animate(withDuration: 0.5,
            delay: 0,
            options: [],
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                self.view.layoutIfNeeded()
            },
            completion : { _ in
                swap(&self.currentQuestionLabel,
                     &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint,
                     &self.nextQuestionLabelCenterXConstraint)
                
                self.updateOffScreenLabel()
            })
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    

}

