//
//  ViewController.swift
//  myButton
//
//  Created by LEOFALCON on 2017. 7. 17..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button = MyButton()
    var disableButton = UIButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        button = MyButton(frame : CGRect(x: 100, y: 100, width: 100.0, height: 100.0))
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3.0
        view.addSubview(button)
        
        
        disableButton = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        disableButton.center = CGPoint(x: 50, y: 50)
        disableButton.setTitle("Test Button", for: .normal)
        disableButton.backgroundColor = .blue
        disableButton.addTarget(self, action: #selector(toggleEnableAndDisable), for: .touchUpInside)
        view.addSubview(disableButton)
    }
    
    func toggleEnableAndDisable()  {
        if self.button.isEnable{
            self.button.makeDisable()
            disableButton.setTitle("Enable", for: .normal)
        } else{
            self.button.makeEnable()
            disableButton.setTitle("Disable", for: .normal)
        }
    }

}

