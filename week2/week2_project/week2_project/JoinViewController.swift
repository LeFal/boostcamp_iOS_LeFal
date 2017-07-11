//
//  JoinViewController.swift
//  week2_project
//
//  Created by LEOFALCON on 2017. 7. 9..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var checkPasswordTextField: UITextField!
    @IBOutlet var introduceSelfTextView: UITextView!
    
    var isCorrectEmail = false
    var isCorrectPassword = false
    var isSamePassword = false
    
    @IBOutlet var emailFeedback: UIView!
    var email : String?
    @IBOutlet var passwordFeedback: UIView!
    var password : String?
    @IBOutlet var checkPasswordFeedback: UIView!
    var checkPassword : String?
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        checkPasswordTextField.setBottomBorder()
        
        introduceSelfTextView.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        introduceSelfTextView.layer.borderColor = UIColor.gray.cgColor
        introduceSelfTextView.layer.borderWidth = 0.4
        introduceSelfTextView.text = "자기소개 (선택)"
        introduceSelfTextView.textColor = UIColor.lightGray
        
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 45
        signUpButton.isEnabled = false
        
        emailFeedback.layer.cornerRadius = 5
        passwordFeedback.layer.cornerRadius = 5
        checkPasswordFeedback.layer.cornerRadius = 5
    }
    
    @IBAction func pickProfileImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        if let password = passwordTextField.text, let checkPassword = checkPasswordTextField.text {
            if password == checkPassword {
                dismiss(animated: true, completion: nil)
            }
            else{
                print("Password is not same")
            }
        }
    }
    
    @IBAction func cancelJoin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard (sender : Any) {
        view.endEditing(true)
    }
    
    // MARK: - Check Validity
    
    @IBAction func emailTextField(textField : UITextField) {
        if let email = textField.text {
            self.email = email
            if isValidEmail(testStr: email) {
                isCorrectEmail = true
                emailFeedback.backgroundColor = UIColor(colorWithHexValue: 0x0097ff)
            } else {
                isCorrectEmail = false
                emailFeedback.backgroundColor = .lightGray
            }
        }
        isAllVaild()
    }
    
    @IBAction func passwordTextField(textField : UITextField) {
        if let password = textField.text {
            self.password = password
            if password.characters.count > 5 {
                isCorrectPassword = true
                passwordFeedback.backgroundColor = UIColor(colorWithHexValue: 0x0097ff)
            } else{
                isCorrectPassword = false
                passwordFeedback.backgroundColor = .lightGray
            }
            if self.password == self.checkPassword {
                isSamePassword = true
                checkPasswordFeedback.backgroundColor = UIColor(colorWithHexValue: 0x0097ff)
            } else{
                isSamePassword = false
                checkPasswordFeedback.backgroundColor = .lightGray
            }
        }
        isAllVaild()
    }
    
    @IBAction func checkPasswordTextField(textField : UITextField) {
        if let checkPassword = textField.text {
            self.checkPassword = checkPassword
            if checkPassword.characters.count > 5 && self.password == self.checkPassword {
                isSamePassword = true
                checkPasswordFeedback.backgroundColor = UIColor(colorWithHexValue: 0x0097ff)
            } else{
                isSamePassword = false
                checkPasswordFeedback.backgroundColor = .lightGray
            }
        }
        isAllVaild()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isAllVaild() {
        if self.isCorrectEmail && self.isCorrectPassword && self.isSamePassword{
            self.signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(colorWithHexValue: 0x0097ff)
            signUpButton.setTitleColor(.white, for: .normal)
        } else {
            signUpButton.backgroundColor = .lightGray
            self.signUpButton.isEnabled = false
        }
    }
    
    // MARK: - Delegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if introduceSelfTextView.textColor == UIColor.lightGray {
            introduceSelfTextView.text = nil
            introduceSelfTextView.textColor = UIColor.black
        }
        scrollView.setContentOffset(CGPoint(x:0,y:150), animated: true)
    }

    
    func textViewDidEndEditing(_ textView: UITextView) {
        if introduceSelfTextView.text.isEmpty {
            introduceSelfTextView.text = "자기소개 (선택)"
            introduceSelfTextView.textColor = UIColor.lightGray
        }
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.profileImageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
}


