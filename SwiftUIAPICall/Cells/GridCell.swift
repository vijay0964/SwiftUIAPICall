//
//  GridCell.swift
//  SwiftUIAPICall
//
//  Created by Augray on 28/08/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct GridCell: View {
    var photo: Photo
    
    var body: some View {
        VStack() {
            ImageView(withURL: photo.thumb)
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: Alignment.center)
        }
    }
}
