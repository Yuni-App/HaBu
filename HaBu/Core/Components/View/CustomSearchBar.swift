//
//  CustomSearchBar.swift
//  HaBu
//
//  Created by yusuf on 4.12.2023.
//

import SwiftUI

struct CustomSearchBar: View {
    var destinaiton : AnyView
    var body: some View {
        HStack{
            NavigationLink(destination: destinaiton.navigationBarBackButtonHidden(true)) {
                Image.iconManager(AppIcon.back, size: 25, weight: .bold, color: .black)
            }
        }
    }
}


#Preview {
    CustomSearchBar(destinaiton: AnyView(TabbarView()))
}
