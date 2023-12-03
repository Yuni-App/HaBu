//
//  BlockedUsers.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI

struct BlockedUsers: View {
    let blockedList : [User] = User.MockData
    var body: some View {
        NavigationStack{
            VStack{
                BlockedViewAppBar(blockedList: blockedList)
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
}


#Preview {
    BlockedUsers()
}

@ViewBuilder
func BlockedViewAppBar(blockedList : [User])->some View {
    ZStack{
        HStack{
            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                Image.iconManager(AppIcon.back, size: 35, weight: .bold, color: .black)
            }
            Spacer()
            Text("\(String(blockedList.count)) Kişi ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        Text("Engellenenler")
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.system(size: 25))
            .frame(maxWidth: .infinity, alignment: .center)
        Spacer()
    }.background(
        .white
    )
    .padding(.horizontal , 10)
}
