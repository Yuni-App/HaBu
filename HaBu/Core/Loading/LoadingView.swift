//
//  LoadingView.swift
//  HaBu
//
//  Created by mert alp on 24.12.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Yuni...").foregroundStyle(Const.primaryColor).font(.custom("Kodchasan-Bold", size: 40))
            .padding(10)
    }
}

#Preview {
    LoadingView()
}
