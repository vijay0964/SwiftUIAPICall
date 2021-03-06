//
//  SplashView.swift
//  SwiftUIAPICall
//
//  Created by Augray on 23/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            AppBackgroungView()
            Text(Strings.SwiftUIAPICall)
                .font(Font.appTitleFont)
                .foregroundColor(.white)
                .onAppear(perform: showHome)
        }
    }
    
    func showHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: HomeView())
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
