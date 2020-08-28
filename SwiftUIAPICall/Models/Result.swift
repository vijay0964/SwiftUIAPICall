//
//  Result.swift
//  SwiftUIAPICall
//
//  Created by Augray on 21/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import Foundation

class Result<T: Codable>: Codable, ObservableObject {
    
    var items: [T]
    var currentPage: Int
    var totalPage: Int
    var total: Int
    
    private enum CodingKeys: String, CodingKey {
        case totalPage = "pages", currentPage = "page", total = "total", items = "photo"
    }
    
    var next: Int {
        return currentPage + 1
    }
    
    var hasNext: Bool {
        return totalPage > currentPage
    }
    
    @discardableResult func merge(_ result: Result<T>) -> Result<T> {
        self.currentPage = result.currentPage
        self.total = result.total
        self.totalPage = result.totalPage
        self.items += result.items
        return self
    }
}
