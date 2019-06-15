//
//  Gryphon+.swift
//  spajam2019-main
//
//  Created by 野村弘樹 on 2019/06/15.
//  Copyright © 2019 Misaki Masashi. All rights reserved.
//

import Foundation
import Alamofire

class InstagramAPI {
    
    // required `Requestable`
    var baseURL: String
    {
        return "http://127.0.0.1:5000"
    }
    
    // required `Requestable`
    var getMedia: String
    {
        return baseURL + "/media"
    }
    
    let headers: HTTPHeaders = [
        "Contenttype": "application/json"
    ]
    
    var contentBody : [String: Any] = [
        "title" : "test"
    ]
    
    // Returns message(String) from server or error reason(Error).
    func getMessage()
    {
        let url = getMedia
        
        Alamofire.request(url, method: .post, parameters: contentBody, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let result = response.result.value as? [String: Any] {
                print(result)
            }
        }
    }
}
