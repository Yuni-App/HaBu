//
//  BlockedUsers.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI

struct BlockedUsers: View {
    @Environment(\.dismiss) private var dismiss
    let blockedList : [User] = User.MockData
    var body: some View {
            VStack{
                CustomSettingsTollBar(action: {
                    dismiss()
                }, title: "Engellenenler", blockedCount:  blockedList.count)
                ScrollView{
                    VStack{
                        if blockedList.count == 0 {
                            Text("Engellenenler Listeniz Boş").frame(height: Const.height/2).fontWeight(.bold)
                        }else {
                            ForEach(blockedList, id: \.id){ user in
                                BlockedUserListTile(user: user)
                                Divider()
                        }
                        }
                    }
                }.frame(width: Const.width)
                    .background(
                        Const.primaryBackGroundColor
                )
            }
    }
}


#Preview {
    BlockedUsers()
}

@ViewBuilder
private func BlockedUserListTile(user : User)->some View {
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
            CustomButton(title: "Kaldır", backgroundColor: Const.primaryButtonColor, action: {
                false
            } ,size: CustomButtonSize.xxxsmall)
        }.padding(.horizontal ,15)
        .padding(.vertical,5)
    
}



