//
//  ConversionViewController.swift
//  week2_book_ch4_WorldTrotter
//
//  Created by LEOFALCON on 2017. 7. 3..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel : UILabel!
    @IBOutlet var fahrenheitTextField : UITextField!
    
    var fahrenheitValue : Double? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue : Double? {
        if let fahrenheitValue = fahrenheitValue {
            return (fahrenheitValue - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }

    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value : celsiusValue))
        }
        else{
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField : UITextField){
        celsiusLabel.text = textField.text
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender : AnyObject) {
        fahrenheitTextField.resignFirstResponder()
    }
    
    
    
}
