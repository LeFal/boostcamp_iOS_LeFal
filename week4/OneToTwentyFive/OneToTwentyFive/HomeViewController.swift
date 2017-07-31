//
//  HomeViewController.swift
//  OneToTwentyFive
//
//  Created by LEOFALCON on 2017. 7. 23..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var chooseNumberOfButtons: UIPickerView!
    
    let numberOfButtonArray = ["4 * 4","6 * 6","8 * 8"]
    var userChooseNumber = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        chooseNumberOfButtons.delegate = self
        chooseNumberOfButtons.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat,.autoreverse], animations: {
            self.titleLabel.transform = self.titleLabel.transform.scaledBy(x:0.5,y:0.5)
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        self.titleLabel.transform = self.titleLabel.transform.scaledBy(x: 2, y: 2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPlay"  {
            let playViewController = segue.destination as! PlayViewController
            playViewController.buttonCount = userChooseNumber
        }
    }
    
}


extension HomeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfButtonArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOfButtonArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0 : userChooseNumber = 4
        case 1 : userChooseNumber = 6
        case 2 : userChooseNumber = 8
            
        default:
            userChooseNumber = 4
        }
    }
}
