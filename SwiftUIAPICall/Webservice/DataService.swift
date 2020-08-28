//
//  DataService.swift
//  SwiftUIAPICall
//
//  Created by Augray on 24/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import Foundation

class DataService {
    typealias BoolCompletion = ((Bool) -> Void)?
    typealias ResultCompletion<T: Codable> = ((Result<T>?) -> Void)?
    
    static func requestEndpoint(_ endpoint: EndPoint, completion: @escaping ((Data?) -> Void)) {
        guard let url = endpoint.endPointURL else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("API Error: \(error!.localizedDescription)")
                }
                completion(data)
            }
        }.resume()
    }
    
    func getRecentPhotos(_ page: Int = 1, completion: ResultCompletion<Photo> = nil) {
        DataService.requestEndpoint(.getRecentPhotos(page)) { (data) in
            guard let data = data else {
                completion?(nil)
                return
            }
            
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                if let photos = dict["photos"] {
                    let data = try JSONSerialization.data(withJSONObject: photos, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode(Result<Photo>.self, from: data)
                    completion?(result)
                } else if let message = dict["message"] {
                    print("API Error: \(message)")
                    completion?(nil)
                }
            } catch (let e) {
                print(e)
                completion?(nil)
            }
        }
    }
}

