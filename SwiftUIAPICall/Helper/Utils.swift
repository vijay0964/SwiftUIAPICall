//
//  Utils.swift
//  SwiftUIAPICall
//
//  Created by Augray on 20/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content.padding(10)
            .foregroundColor(.white)
            .font(Font.buttonFont)
    }
}

struct AppBackgroungView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .orange, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
        }
    }
}
