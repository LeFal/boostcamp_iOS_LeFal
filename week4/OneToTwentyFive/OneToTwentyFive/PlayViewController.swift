//
//  PlayViewController.swift
//  OneToTwentyFive
//
//  Created by LEOFALCON on 2017. 7. 23..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    @IBOutlet var gameBoard: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tapToStartButton: UIButton!
    
    var timer : Timer?
    var gameCounter = 0
    var elapsedTime: TimeInterval = 0
    var buttons : [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "00:00.00"
        gameCounter = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gameCounter = 1
    }
    
    //
    // MARK: - Relate With Timmer
    //
    
    func startTimer()  {
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        elapsedTime = 0
    }
    
    func updateTime(){
        elapsedTime += 0.01
        timeLabel.text = String(describing: time)
        timeLabel.text = timeIntervalToString(interval: elapsedTime)
    }
    
    func timeIntervalToString(interval : TimeInterval) -> String {
        
        let onlySecond = Int(interval)
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 100)
        let seconds = onlySecond % 60
        let minutes = (onlySecond / 60) % 60
        return String(format: "%0.2d:%0.2d.%0.2d",minutes,seconds,ms)
    }
    
    //
    // MARK: - Relate With Button
    //
    
    
    @IBAction func tapToStart(_ sender: Any) {
        self.tapToStartButton.isHidden = true
        startTimer()
        makeBtn()
        assignNumberToBtn()
    }
    

    func makeBtn()  {
        var x = 0
        var y = 0
        let btnHeightAndWidth = 54
        let spaceBetweenBtn = 12
        
        for _ in 1...5 {
            x = 0
            for _ in 1...5 {
                let btn = UIButton(frame: CGRect(x: x, y: y, width: btnHeightAndWidth, height: btnHeightAndWidth))
                btn.setTitle("", for: .normal)
                btn.backgroundColor = .black
                btn.setTitleColor(.white, for: .normal)
                btn.addTarget(self, action: #selector(checkBtnIsRightNum(sender:)), for: .touchUpInside)
                self.gameBoard.addSubview(btn)
                buttons.append(btn)
                x += btnHeightAndWidth + spaceBetweenBtn
            }
            y += btnHeightAndWidth + spaceBetweenBtn
        }
    }

    
    func assignNumberToBtn()  {
        var leftNumArray: [Int] = []
        var randomNum :UInt32 = 0
        var pickedNum = 0
        var buttonTitle = ""
        
        for i in 1...25 {
            leftNumArray.append(i)
        }
        
        for i in 0...24 { // 수정 필요
            randomNum = arc4random_uniform(UInt32(leftNumArray.count - 1))
            pickedNum = leftNumArray.remove(at: Int(randomNum))
            buttonTitle = "" + "\(pickedNum)"
            buttons[i].setTitle(buttonTitle, for: .normal)
        }
        
    }

    
    func checkBtnIsRightNum(sender : UIButton) {
        if String(gameCounter) == sender.titleLabel?.text {
            sender.isHidden = true
            gameCounter += 1
        }
        if sender.titleLabel?.text == "25" {
            timer?.invalidate()
            tapToStartButton.isHidden = false
            
            let getUserName = UIAlertController(title: "기록", message: nil, preferredStyle: .alert)
            getUserName.addTextField { (textField: UITextField) in
                textField.placeholder = "이름을 입력하세요."
            }
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            getUserName.addAction(ok)
            
            self.present(getUserName, animated: true, completion: nil)
            buttons.removeAll()
            gameCounter = 1
        }
        
    }
    
    @IBAction func goToHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
