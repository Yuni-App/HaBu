//
//  SearchItem3.swift
//  HaBu
//
//  Created by yusuf on 4.12.2023.
//

import SwiftUI

struct SearchItem3: View {
    var user: User
    @State private var deneme = false
    
    var body: some View {
        
        NavigationLink(destination: ProfileView(hideTab: $deneme , user: user), label: {
            HStack {
                CircleProfileImage(userIamgeUrl: "Mert", size: .xsmall)
                VStack {
                    HStack {
                        Text("\(user.name) \(user.surname)").fontWeight(.semibold).foregroundStyle(Color.black)
                        Spacer()
                    }
                    HStack {
                        Text("\(user.department)").font(.footnote).fontWeight(.semibold).foregroundStyle(Color(UIColor(hex: "777777")))
                        Spacer()
                    }
                }
            }.padding()
                .frame(width: Const.width * 0.9, height: Const.height * 0.07).background(Color(UIColor(hex: "F0F0F0"))).cornerRadius(10)
        }
        )
    }
    }


#Preview {
    SearchItem3(user: User.MockData[0])
}
