//
//  LikesListTile.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct LikesListTile: View {
    var user : User
    init(user:User) {
        self.user = user
    }
    var body: some View {
        NavigationStack{
            HStack {
                CircleProfileImage(userIamgeUrl: "", size: .xsmall)
                VStack{
                    Text("\(user.name) \(user.surName)")
                        .fontWeight(.semibold)
                        .font(.caption)
                    Text("\(user.username)")
                        .opacity(0.5)
                        .fontWeight(.semibold)
                        .font(.caption2)
                }
                .foregroundStyle(.black)
                Spacer()
                //CustomButton(title: "Profili Gör", backgroundColor: Const.primaryColor, action: {} , destinaiton: AnyView(  ProfileView(user: User.MockData[0])),width: Const.width/3)
                
            }
        }
    }
}

#Preview {
    LikesListTile(user: User.MockData[0])
}
