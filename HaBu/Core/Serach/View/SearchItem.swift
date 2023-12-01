//
//  SearchItem.swift
//  HaBu
//
//  Created by yusuf on 1.12.2023.
//

import SwiftUI

struct SearchItem: View {
    var user: User
    var ratingSorted: Bool
        
        var body: some View {
            NavigationLink(destination: Text("ProfileView")) {
                HStack() {
                    CircleProfileImage(userIamgeUrl: "", size: .small).frame(width: Const.width * 0.15)
                    VStack(alignment: .leading) {
                        Text("\(user.name) \(user.surName)")
                            .opacity(0.85)
                            .font(.title3)
                        Text(user.department).opacity(0.6).font(.footnote)
                    }
                    Spacer()
                    HStack {
                        switch (ratingSorted, user.rating) {
                        case (false, 20...30):
                            Image(systemName:"star.fill")
                                .foregroundColor(Color(UIColor(hex: "#CD7F32")))
                        case(false, 30...40):
                            Image(systemName:"star.fill")
                                .foregroundColor(Color(UIColor(hex: "#808080")))
                        case (false, 40...65):
                            
                            Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                            )
                            
                        case (false, 65...100):
                            Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                            )
                            Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                            )
                            Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                            )
                            
                            
                        default:
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }.frame(width: Const.width * 0.2)
                }
                .frame(width: Const.width * 0.9, height: Const.height * 0.08, alignment: .leading)
                .background(Color(UIColor(hex: "#FFFBF1"))).cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 10)
                .foregroundStyle(.black)
                .padding(.leading, 3)
            }
        }
}

#Preview {
    SearchItem(user: User.MockData[0], ratingSorted: true)
}
