//
//  DetailView.swift
//  SwiftUIAPICall
//
//  Created by Augray on 24/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var photo: Photo
    
    var body: some View {
        ZStack {
            AppBackgroungView()
            VStack {
                ImageView(withURL: photo.path)
                Text(photo.title).modifier(TextModifier())
                Spacer()
            }
        }.navigationBarTitle("Photo")
    }
}
