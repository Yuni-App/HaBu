//
//  SearchItem2.swift
//  HaBu
//
//  Created by yusuf on 2.12.2023.
//

import SwiftUI

struct SearchItem2: View {
    var user: User
    var ratingSorted: Bool
    
    var body: some View {
        NavigationLink(destination: Text("ProfileView")) {
            VStack() {
                VStack() {
                    Image("Mert").resizable().cornerRadius(10)
                
                }.overlay( //kenarlıklar
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 1.3)
                        .stroke(.white, lineWidth: 2)
                ).frame(width: Const.width * 0.28 ,height: Const.height * 0.13)
                VStack{
                    Text("\(user.name) \(user.surName)").font(.headline).foregroundStyle(Color.black)
                }
                HStack{
                    Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#C0C0C0")))
                    Text("\(user.rating, specifier: "%.0f")").foregroundStyle(Color.black)
                }
            }
            .background()
            .frame(width: Const.width * 0.3, height: Const.height * 0.18)
        }
    }}

#Preview {
    SearchItem2(user: User.MockData[0], ratingSorted: true)
}
