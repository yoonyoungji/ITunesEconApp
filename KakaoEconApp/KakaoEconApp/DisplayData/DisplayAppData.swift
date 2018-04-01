//
//  DisplayAppData.swift
//  KakaoEconApp
//
//  Created by YoungD on 2018. 4. 1..
//  Copyright © 2018년 YoungD. All rights reserved.
//

import UIKit


struct DisplayAppData {
    
    var id = String()
    var appName = String()
    var imageURL = String()
    var summary = String()
    var category = String()
    
    var desc = String()
    var appInformation: Any?
    
    init(dictionary: [String: Any]) {
        if let idDictionary = dictionary["id"] as? [String: Any],
            let idAttributes = idDictionary["attributes"] as? [String: Any] {
            self.id = idAttributes["im:id"] as? String ?? ""
        }
        
        if let appName = dictionary["im:name"] as? [String: Any] {
            self.appName = appName["label"] as? String ?? ""
        }
        
        if let summary = (dictionary["summary"] as? [String: Any])?["label"] as? String {
            self.summary = summary
        }
        
        if let category = dictionary["category"] as? [String: Any],
            let categoryAttributes = category["attributes"] as? [String: Any] {
            self.category = categoryAttributes["label"] as? String ?? ""
        }
        
        if let imageURLArray = dictionary["im:image"] as? [[String: Any]] {
            switch UIScreen.main.scale{
            case 1.0:
                self.imageURL = imageURLArray[0]["label"] as? String ?? ""
            case 2.0:
                self.imageURL = imageURLArray[1]["label"] as? String ?? ""
            case 3.0:
                self.imageURL = imageURLArray[2]["label"] as? String ?? ""
            default:
                self.imageURL = imageURLArray[1]["label"] as? String ?? ""
            }
        }
        
        
    }
    
    init(id: String?, appName: String?, imageURL: String?, summary: String?, category: String?) {
        self.id = id ?? ""
        self.appName = appName ?? ""
        self.imageURL = imageURL ?? ""
        self.summary = summary ?? ""
        self.category = category ?? ""
    }
    
    
}
