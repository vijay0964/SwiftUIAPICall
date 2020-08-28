//
//  DataEndPoint.swift
//  SwiftUIAPICall
//
//  Created by Augray on 24/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import Foundation

struct ServerInfo {
    static let Flickr_API_Key = "Flickr_API_Key"
    
    static let host = "https://www.flickr.com/"
    static let prefix = "services/rest/"
    static let method = "?method="
    static let APIKey = "&api_key=\(Flickr_API_Key)"
    static let format = "&format=json&nojsoncallback=1"
    static let authToken = "&auth_token=72157715571028558-53ad88237bf2d216"
    static let APISign = "&api_sig=9539d47e2c4bb1151501f1532a5fb0aa"
    static let page = "&page="
}

enum EndPoint {
    case getRecentPhotos(Int)
    
    var rawValue: String {
        switch self {
        case .getRecentPhotos(_):
            return "flickr.photos.getRecent"
        }
    }
    
    var endPointURL: URL? {
        switch self {
        case .getRecentPhotos(let page):
            let path = "\(ServerInfo.host)\(ServerInfo.prefix)\(ServerInfo.method)\(rawValue)\(ServerInfo.APIKey)\(ServerInfo.format)\(ServerInfo.page)\(page)"
            return URL(string: path)
        }
    }
}

//https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=ce63de9690ed670ff7d319bd7be26989&format=json&nojsoncallback=1&auth_token=72157715571028558-53ad88237bf2d216&api_sig=9539d47e2c4bb1151501f1532a5fb0aa
