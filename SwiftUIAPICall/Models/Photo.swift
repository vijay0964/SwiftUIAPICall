//
//  Photo.swift
//  SwiftUIAPICall
//
//  Created by Augray on 21/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import Foundation

class Photo: Codable, Identifiable, ObservableObject {
    
    internal let id: String
    private let owner: String
    private let secret: String
    private let server: String
    private let farm: Int
    internal let title: String
    
    var path: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    var url: URL {
        return URL(string: path)!
    }
    
    var thumb: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_t.jpg"
    }
    
    var thumbURL: URL {
        return URL(string: thumb)!
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
