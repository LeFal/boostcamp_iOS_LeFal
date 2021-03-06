//
//  Photo.swift
//  Photorama
//
//  Created by LEOFALCON on 2017. 7. 31..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit


class Photo {
    let title : String
    let remoteURL : URL
    let photoID : String
    let dateTaken : Date
    var image : UIImage?
    
    init(title:String, photoID : String, remoteURL : URL, dateTaken : Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken  = dateTaken
    }
}

extension Photo: Equatable {
    static func  == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
}

