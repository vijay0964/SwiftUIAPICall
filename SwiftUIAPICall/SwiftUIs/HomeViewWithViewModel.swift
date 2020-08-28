//
//  HomeViewWithViewModel.swift
//  SwiftUIAPICall
//
//  Created by Augray on 28/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI
import QGrid

struct HomeViewWithViewModel: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                AppBackgroungView()
                    .navigationBarTitle(Strings.FlickrPhotos)
                if viewModel.photos == nil {
                    Text(Strings.Loading).modifier(TextModifier())
                        .onAppear {
                            self.viewModel.loadPhoto()
                    }
                } else {
                    QGrid(viewModel.photos,
                          columns: 4,
                          vSpacing: 2,
                          hSpacing: 2,
                          vPadding: 2,
                          hPadding: 2) { photo in
                            NavigationLink(destination: DetailView(photo: photo)) {
                                GridCell(photo: photo).onAppear {
                                    self.viewModel.doPagination(photo)
                                }
                            }
                    }
                }
            }
        }
    }
}
