//
//  BlockedUserListTile.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI

struct BlockedUserListTile: View {
    var user : User
    init(user:User) {
        self.user = user
    }
    var body: some View {
        NavigationStack{
            HStack {
                CircleProfileImage(userIamgeUrl: "", size: .small)
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
                CustomButton(title: "Kaldır", backgroundColor: Const.primaryColor, action: {
                    
                } ,width: Const.width/3)
               
            }
        }
    }
}


#Preview {
    BlockedUserListTile(user: User.MockData[0])
}
