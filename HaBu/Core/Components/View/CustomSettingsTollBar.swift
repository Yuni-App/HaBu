//
//  CustomSettingsTollBar.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct CustomSettingsTollBar: View {
    var title : String
    var destinaiton : AnyView
    var blockedCount:  Int?
    var body: some View {
        ZStack{
            HStack{
                NavigationLink(destination: destinaiton.navigationBarBackButtonHidden(true)) {
                    Image.iconManager(AppIcon.back, size: 35, weight: .bold, color: .black)
                }
                Spacer()
                if let blockedCount = blockedCount{
                    Text("\(blockedCount) Kişi ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            Text(title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 25))
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }.background(
            .white
        )
        .padding(.horizontal , 10)
    }

}

#Preview {
    CustomSettingsTollBar(title: "Baslık", destinaiton: AnyView(TabbarView()))
}
