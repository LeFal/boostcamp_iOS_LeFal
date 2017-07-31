//
//  User.swift
//  ImageBoard
//
//  Created by LEOFALCON on 2017. 7. 31..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import Foundation

class User {
    static let shared = User()
    var _id : Int?
    var nickname : String?
    var password : String?
    var email : String?
    
//    init(_id : Int?, nickname : String?, password : String?, email : String?) {
//        self._id = _id
//        self.nickname = nickname
//        self.password = password
//        self.email = email
//    }
}
