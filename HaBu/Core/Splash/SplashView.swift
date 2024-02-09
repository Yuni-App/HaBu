//
//  LoadingView.swift
//  HaBu
//
//  Created by mert alp on 24.12.2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Image("yuniSplash")
                .resizable()
            .frame(width: Const.width * 0.8,height: Const.width * 0.45)
            
        }
        .frame(width: Const.width,height: Const.height)
        .background(Const.LinearBackGroundColor.opacity(0.6))
       
    }
}

#Preview {
    SplashView()
}
