//
//  FlickerAPI.swift
//  Photorama
//
//  Created by LEOFALCON on 2017. 7. 30..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import Foundation

enum Method : String {
    case recentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

enum FlickerError : Error {
    case invaildJSONData
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        return formatter
    }()
    
    private static func flickrURL(method : Method, parameters : [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method" : method.rawValue,
            "format" : "json",
            "nojsoncallback" : "1",
            "api_key": APIKey
        ]
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key,value) in additionalParams {
                let item : URLQueryItem = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components?.queryItems = queryItems
        
        if let url = components?.url {
            return url
        } else {
            return URL(string: "")!
        }
        
        
    }
    
    static func recentPhotosURL() -> URL {
        return flickrURL(method: .recentPhotos, parameters: ["extras":"url_h,date_taken"])
    }
    
    
    private static func photoFromJSONObject(json: [String :Any]) -> Photo? {
        guard let photoID = json["id"] as? String,
            let title = json["title"] as? String,
            let dateString = json["datetaken"] as? String,
            let photoURLString = json["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from: dateString) else {
                return nil
        }
        return Photo(title: title, photoID: photoID, remoteURL: url, dateTaken: dateTaken)
    }

    
    static func photosFromJSONData(data : Data) -> PhotosResult {
        do {
            let jsonObject : Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [String : Any],
                let photos = jsonDictionary["photos"] as? [String:Any],
                let photosArray = photos["photo"] as? [[String:Any]] else {
                    return .failure(FlickerError.invaildJSONData)
            }
            var finalPhotos = [Photo]()
            for photoJSON in photosArray {
                if let photo = photoFromJSONObject(json: photoJSON){
                    finalPhotos.append(photo)
                }
            }
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .failure(FlickerError.invaildJSONData)
            }
            return .success(finalPhotos)
        } catch let error  {
            return .failure(error)
        }
    }
}
