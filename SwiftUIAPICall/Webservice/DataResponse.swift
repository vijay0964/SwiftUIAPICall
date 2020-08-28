//
//  DataResponse.swift
//  SwiftUIAPICall
//
//  Created by Augray on 22/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import Combine
import SwiftUI

final class DataResponse<A: Codable>: ObservableObject {
    let didChange = PassthroughSubject<A?, Never>()
    let endpoint: EndPoint
    
    var value: A? {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(self.value)
            }
        }
    }
    
    init(endpoint: EndPoint) {
        self.endpoint = endpoint
        load()
    }
    
    func load() {
        switch endpoint {
        case .getRecentPhotos:
            getRecentPhotos()
        }
    }
    
    func getRecentPhotos(_ page: Int = 1) {
        DataService.requestEndpoint(.getRecentPhotos(page)) { (data) in
            guard let data = data else {
                return
            }
            
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                if let photos = dict["photos"] {
                    let data = try JSONSerialization.data(withJSONObject: photos, options: .fragmentsAllowed)
                    let result = try JSONDecoder().decode(A.self, from: data)
                    
                    self.value = result
                } else if let message = dict["message"] {
                    print("API Error: \(message)")
                }
            } catch (let e) {
                print(e)
            }
        }
    }
}
