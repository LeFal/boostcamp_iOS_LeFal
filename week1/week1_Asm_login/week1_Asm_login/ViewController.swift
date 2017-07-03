//
//  ViewController.swift
//  week1_Asm_login
//
//  Created by LEOFALCON on 2017. 7. 1..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ID: UITextField!
    @IBOutlet var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signIn(_ sender: Any) {
        if let id = self.ID.text, let password = self.password.text {
            print("touch up inside - sign in")
            print("ID : \(id), PW : \(password)")
        } else{
            print("touch up inside - sign in")
            print("Invalid ID or PW")
        }
    }

    @IBAction func signUp(_ sender: Any) {
        print("touch up inside - sign up")
    }
}

