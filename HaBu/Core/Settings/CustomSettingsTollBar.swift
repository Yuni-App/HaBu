//
//  CustomSettingsTollBar.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI
struct CustomSettingsTollBar: View {
    var action : () -> Void
    var title : String
    var blockedCount:  Int?
    var body: some View {
        ZStack{
            HStack{
                Buttons.backButton(action: {
                    action()
                }, color: .black)
                Spacer()
                if let blockedCount = blockedCount{
                    Text("\(blockedCount) Kişi ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }.padding(.leading,5)
            Text(title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 25))
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
        .frame(width: Const.width, height: Const.height/22)
        .background(
            .white
        )
        
    }

}

#Preview {
  SettingsView()
}
