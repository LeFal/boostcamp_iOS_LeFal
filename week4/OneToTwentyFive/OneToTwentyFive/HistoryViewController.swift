//
//  HistoryViewController.swift
//  OneToTwentyFive
//
//  Created by LEOFALCON on 2017. 7. 23..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var recordStore : RecordStore!
    @IBOutlet var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordStore = RecordStore.sharedRecordStore
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
    }

    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func reset(_ sender : Any){
        let resetAlertController = UIAlertController(title: "Reset", message: "정말 초기화 하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) {  _ in
            self.recordStore.resetRecord()
            self.historyTableView.reloadData()
        }
        resetAlertController.addAction(cancel)
        resetAlertController.addAction(ok)
        
        self.present(resetAlertController, animated: true, completion: nil)
        
        
    }
    
  
}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordStore.allRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "recordTableViewCell", for: indexPath)
        
        let recordTime = recordStore.allRecord[indexPath.row].recordTime.convertToString()
        let userName = recordStore.allRecord[indexPath.row].name
        let recordDate = recordStore.allRecord[indexPath.row].recordDate
        
        cell.textLabel?.text = recordTime
        cell.detailTextLabel?.text = "\(userName)(\(recordDate))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteRecord = recordStore.allRecord[indexPath.row]
            recordStore.removeRecord(deleteRecord)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
}
