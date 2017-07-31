//
//  LoginService.swift
//  ImageBoard
//
//  Created by LEOFALCON on 2017. 7. 31..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import Foundation

enum LoginResult {
    case success
    case failure
}

class LoginService {
    private let baseURL = "https://ios-api.boostcamp.connect.or.kr/login"

    func loginURL(parameter: [String:String]?) -> URL {
        var URLComponent = URLComponents(string: self.baseURL)
        
        var queryItem = [URLQueryItem]()
        if let parameter = parameter {
            for (key,value) in parameter {
                let item = URLQueryItem(name: key, value: value)
                queryItem.append(item)
            }
        }
        
        URLComponent?.queryItems = queryItem
        
        guard let loginURL = URLComponent?.url else { return URL(string : baseURL)! }

        return loginURL
    }

    let session : URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    

    func loginAuthorization(email : String, password : String, completion : @escaping (LoginResult) -> Void ) {
        let loginParameter = ["email":email,"password": password]
        var url = self.loginURL(parameter: loginParameter)
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result =
            completion(result)
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data : Data?, error: Error?) -> LoginResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photosFromJSONData(data: jsonData)
    }

    
    
}
