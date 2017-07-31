//
//  PlayViewController.swift
//  OneToTwentyFive
//
//  Created by LEOFALCON on 2017. 7. 23..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var recordStore : RecordStore!
    
    @IBOutlet var goToHistoryViewController: UIButton!
    @IBOutlet var topRecordUser: UILabel!
    @IBOutlet var topRecordTime: UILabel!
    @IBOutlet var gameBoard: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tapToStartButton: UIButton!
    
    var buttonCount : Int = 6
    
    var timer : Timer?
    var gameCounter = 0
    var elapsedTime: TimeInterval = 0
    var buttons : [UIButton] = []
    var touchBeginButtonsQueue : [UIButton] = []
    
    
    override func viewDidLoad() {
        //self.recordStore = _recordStore
        self.recordStore = RecordStore.sharedRecordStore
        super.viewDidLoad()
        timeLabel.text = "00:00.00"
        gameCounter = 1
        
        if recordStore.allRecord.count == 0 {
            topRecordTime.text = "--:--.--"
            topRecordUser.text = "-"
        }else {
            topRecordTime.text = recordStore.allRecord[0].recordTime.convertToString()
            topRecordUser.text = recordStore.allRecord[0].name
        }
        self.goToHistoryViewController.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gameCounter = 1
        self.goToHistoryViewController.isEnabled = true
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
        timeLabel.text = elapsedTime.convertToString()
    }
    
    
    //
    // MARK: - Relate With Button
    //
    
    
    @IBAction func tapToStart(_ sender: Any) {
        self.tapToStartButton.isHidden = true
        startTimer()
        makeBtn()
        assignNumberToBtn()
        self.goToHistoryViewController.isEnabled = false
    }
    

    func makeBtn()  {
        var x : CGFloat = 0
        var y : CGFloat = 0
        let spaceBetweenBtn : CGFloat = 12
        let btnHeightAndWidth = (gameBoard.frame.width - spaceBetweenBtn * CGFloat(buttonCount) - 1) / CGFloat(buttonCount)
        
        
        for _ in 1...buttonCount {
            x = 0
            for _ in 1...buttonCount {
                let btn = UIButton(frame: CGRect(x: x, y: y, width: btnHeightAndWidth, height: btnHeightAndWidth))
                btn.setTitle("", for: .normal)
                btn.backgroundColor = .black
                btn.setTitleColor(.white, for: .normal)
                btn.addTarget(self, action: #selector(checkBtnIsRightNum(sender:)), for: .touchDown)
                btn.addTarget(self, action: #selector(removeAllItemInQueue(sender:)), for: .touchUpInside)
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
        
        let totalButtonCount = buttonCount * buttonCount
        
        for i in 1...totalButtonCount/2 {
            leftNumArray.append(i)
            leftNumArray.append(i)
        }
        
        for i in 0...(totalButtonCount - 1) { // 수정 필요
            randomNum = arc4random_uniform(UInt32(leftNumArray.count - 1))
            pickedNum = leftNumArray.remove(at: Int(randomNum))
            buttonTitle = "" + "\(pickedNum)"
            buttons[i].setTitle(buttonTitle, for: .normal)
        }
        
    }
    func removeAllItemInQueue(sender : UIButton) {
        touchBeginButtonsQueue.removeAll()
    }
    
    func checkBtnIsRightNum(sender : UIButton) {
        if touchBeginButtonsQueue.count == 0  {
            if String(gameCounter) == sender.titleLabel?.text {
                touchBeginButtonsQueue.append(sender)
            }
        }
        else if String(gameCounter) == sender.titleLabel?.text && touchBeginButtonsQueue.count == 1 {
            if sender == touchBeginButtonsQueue[0] {}
            else if  touchBeginButtonsQueue[0].titleLabel?.text == sender.titleLabel?.text {
                touchBeginButtonsQueue[0].isHidden = true
                sender.isHidden = true
                gameCounter += 1
                touchBeginButtonsQueue.removeAll()
                
                if sender.titleLabel?.text == "" + "\(buttonCount * buttonCount/2)" {
                    let recordTime = elapsedTime
                    timer?.invalidate()
                    tapToStartButton.isHidden = false
                    
                    let getUserName = UIAlertController(title: "기록", message: nil, preferredStyle: .alert)
                    getUserName.addTextField { (textField: UITextField) in
                        textField.placeholder = "이름을 입력하세요."
                    }
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
                        if let userName = getUserName.textFields?.first?.text {
                            self.saveRecord(userName: userName, recordTime : recordTime)
                            self.topRecordUser.text = self.recordStore.allRecord[0].name
                            self.topRecordTime.text = self.recordStore.allRecord[0].recordTime.convertToString()
                        } else {
                            self.saveRecord(userName: "",recordTime: recordTime)
                            self.topRecordUser.text = self.recordStore.allRecord[0].name
                            self.topRecordTime.text = self.recordStore.allRecord[0].recordTime.convertToString()
                        }
                    })
                    getUserName.addAction(ok)
                    self.present(getUserName, animated: true, completion: nil)
                    buttons.removeAll()
                    gameCounter = 1
                    elapsedTime = 0
                    self.goToHistoryViewController.isEnabled = true
            }
        } else {
            elapsedTime += 1.5
        }
        
        
       
        }
    }
    
    func saveRecord(userName : String, recordTime : TimeInterval) {
        let recordTime = recordTime
        let name = userName
        let recordDate = Date()
        
        let record = Record(name: name, recordTime: recordTime, recordDate: recordDate)
        recordStore.addRecord(record: record)
    }
    
    @IBAction func goToHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension TimeInterval {
    func convertToString() -> String {
        let onlySecond = Int(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 100)
        let seconds = onlySecond % 60
        let minutes = (onlySecond / 60) % 60
        return String(format: "%0.2d:%0.2d.%0.2d",minutes,seconds,ms)
    }
}
