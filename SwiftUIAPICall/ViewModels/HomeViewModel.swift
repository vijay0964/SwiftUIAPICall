//
//  HomeViewModel.swift
//  SwiftUIAPICall
//
//  Created by Augray on 26/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var photos: [Photo]!
    
    private var result: Result<Photo>! {
        didSet {
            photos = result.items
        }
    }
    
    func loadPhoto(_ page: Int = 1) {
        DataService().getRecentPhotos(page) { (result) in
            self.handleResult(result)
        }
    }
    
    func handleResult(_ response: Result<Photo>?) {
        guard let response = response else {
            return
        }
        
        guard let result = self.result else {
            self.result = response
            return
        }
        
        self.result = result.merge(response)
    }
    
    func doPagination(_ photo: Photo) {
        guard let result = self.result, result.hasNext else {
            return
        }
        
        let currentIndex = result.items.firstIndex(where: { $0.id == photo.id } )
        let lastIndex = result.items.count - 1
        let offset = 5
        
        if currentIndex == (lastIndex - offset) {
            loadPhoto(result.next)
        }
    }
}
