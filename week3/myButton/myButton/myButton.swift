//
//  myButton.swift
//  myButton
//
//  Created by LEOFALCON on 2017. 7. 18..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class MyButton : UIView {
    var isEnable : Bool = true
    var isSelected : Bool = false
    var titleLabel = UILabel()
    var backgroundImage : UIImageView?
    var beforeState = UIControlState()
    var currentState = UIControlState()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.frame = CGRect(x: 100, y: 0, width: 200, height: 21)
        titleLabel.center = CGPoint(x: 50, y: 50)
        titleLabel.textAlignment = .center
        titleLabel.text = "normal"
        super.backgroundColor = .gray
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable {
            currentState = .highlighted
            super.backgroundColor = .red
            titleLabel.text = "highlighted"
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnable {
            if !isSelected {
                currentState = .selected
                super.backgroundColor = .blue
                titleLabel.text = "selected"
                isSelected = true
            } else {
                currentState = .normal
                titleLabel.text = "normal"
                super.backgroundColor = .gray
                isSelected = false
            }
        }
    }
    
    func makeDisable() {
        isEnable = false
        super.alpha = 0.4
        currentState = .disabled
    }
    func makeEnable(){
        isEnable = true
        super.alpha = 1
        if isSelected {
            currentState = .selected
        }
        else {
            currentState = .normal
        }
    }
    
}
