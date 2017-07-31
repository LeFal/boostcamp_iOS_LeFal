//
//  Record.swift
//  OneToTwentyFive
//
//  Created by LEOFALCON on 2017. 7. 24..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import Foundation


class Record : NSObject, NSCoding {
    var name : String = ""
    var recordTime : TimeInterval = 0
    var recordDate : Date = Date()
    
    init(name : String, recordTime : TimeInterval, recordDate : Date) {
        self.name = name
        self.recordTime = recordTime
        self.recordDate = recordDate
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(recordTime, forKey: "recordTime")
        aCoder.encode(recordDate, forKey: "recordDate")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        recordTime = aDecoder.decodeDouble(forKey: "recordTime")
        recordDate = aDecoder.decodeObject(forKey: "recordDate") as! Date
        
        super.init()
    }
    
    
    
    
}
