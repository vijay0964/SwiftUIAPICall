//
//  HomeView.swift
//  SwiftUIAPICall
//
//  Created by Augray on 21/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI
import QGrid

struct HomeView: View {
    
    var response = DataResponse<Result<Photo>>(endpoint: .getRecentPhotos(1))
    @State var photos: [Photo]!
    @State var result: Result<Photo>! {
        didSet {
            photos = result.items
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppBackgroungView()
                    .navigationBarTitle(Strings.FlickrPhotos)
                if photos == nil {
                    Text(Strings.Loading).modifier(TextModifier())
                } else {
                    QGrid(photos,
                          columns: 4,
                          vSpacing: 2,
                          hSpacing: 2,
                          vPadding: 2,
                          hPadding: 2) { photo in
                            NavigationLink(destination: DetailView(photo: photo)) {
                                GridCell(photo: photo).onAppear {
                                    self.doPagination(photo)
                                }
                            }
                        }
                }
            }
            .onReceive(response.didChange) { (response) in
                self.handleResult(response)
            }
        }
    }
    
    func doPagination(_ photo: Photo) {
        guard let result = self.result, result.hasNext else {
            return
        }
        
        let currentIndex = result.items.firstIndex(where: { $0.id == photo.id } )
        let lastIndex = result.items.count - 1
        let offset = 5
        
        if currentIndex == (lastIndex - offset) {
            response.getRecentPhotos(result.next)
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
}
