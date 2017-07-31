//
//  RecordStore.swift
//  OneToTwentyFive
//
//  Created by LEOFALCON on 2017. 7. 24..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import Foundation

//let _recordStore = RecordStore()

class RecordStore {
    static let sharedRecordStore = RecordStore()
    
    var allRecord = [Record]()
    
    init() {
        if let archivedRecords = NSKeyedUnarchiver.unarchiveObject(withFile: self.recordArchiveURL.path) as? [Record] {
            allRecord += archivedRecords
        }
    }
    
    let recordArchiveURL : URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("records.archive")
    }()
    
    func addRecord(record : Record) {
        allRecord.append(record)
        allRecord.sort { (record1, record2) -> Bool in
            return record1.recordTime < record2.recordTime
        }
    }
    
    func removeRecord(_ record : Record) {
        if let index = allRecord.index(of: record) {
            allRecord.remove(at: index)
        }
    }
    
    func resetRecord()  {
        allRecord.removeAll()
    }
    
    func saveChanges() -> Bool {
        print("Save recodes to \(recordArchiveURL)")
        return NSKeyedArchiver.archiveRootObject(allRecord, toFile: recordArchiveURL.path)
    }
}


