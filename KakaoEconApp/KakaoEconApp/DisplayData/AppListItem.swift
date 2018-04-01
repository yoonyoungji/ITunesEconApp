//
//  AppListItem.swift
//  KakaoEconApp
//
//  Created by YoungD on 2018. 4. 1..
//  Copyright © 2018년 YoungD. All rights reserved.
//

import Foundation

enum DataResponse<T> {
    case success(T)
    case failure(Error)
}

class AppListItem{
    let urlString = URL(string: "https://itunes.apple.com/kr/rss/topfreeapplications/limit=\(100)/genre=\(6015)/json")
    func initData(completion: @escaping (DataResponse<[DisplayAppData]>) -> () ){
        URLSession.shared.dataTask(with: urlString!) { data, response, error in
            
            if let error = error {
                return completion(DataResponse.failure(error))
            }
            
            do {
                guard let data = data else { return }
                
                let json = try (JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                
                guard let result = json as? [String: Any],
                    let feed = result["feed"] as? [String: Any],
                    let entry = feed["entry"] as? [[String: Any]] else { return }
                
                
                let appData = entry.map({ dictionary -> DisplayAppData in
                    return DisplayAppData(dictionary: dictionary)
                })
                
                DispatchQueue.main.async {
                    completion(DataResponse.success(appData))
                }
                
            } catch let jsonError {
                completion(DataResponse.failure(jsonError))
            }
        }.resume()
    }
    
    func subItem(id: Int, completion: @escaping (DataResponse<DisplayAppSubData>) -> ()) {
        let urlString = "https://itunes.apple.com/lookup?id=\(id)&country=kr"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.downloadTask(with: url) { location, response, error in
            
            if let error = error {
                return completion(DataResponse.failure(error))
            }
            
            do {
                guard let path = location?.path else { return }
                guard let data = FileManager.default.contents(atPath: path) else { return }
                
                let json = try (JSONSerialization.jsonObject(with: data, options: .mutableContainers))
                guard let jsonDictionary = json as? [String: Any],
                    let results = jsonDictionary["results"] as? [[String: Any]],
                    let dictionary = results.first else { return }
                
                DispatchQueue.main.async {
                    completion(DataResponse.success(DisplayAppSubData(dictionary: dictionary)))
                }
                
            } catch let jsonError {
                completion(DataResponse.failure(jsonError))
            }
            }.resume()
    }

}


