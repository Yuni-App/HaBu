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
            ScrollView{
                VStack{
                    HStack{
                        Text("Engellenenler").fontWeight(.bold)
                        Spacer()
                        Text("\(String(blockedList.count)) Kişi ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }.padding(.bottom , 30)
                    if blockedList.count == 0 {
                        Text("Engellenenler Listeniz Boş").frame(height: Const.height/2).fontWeight(.bold)
                    }else {
                        ForEach(blockedList, id: \.id){ user in
                            BlockedUserListTile(user: user)
                    }
                    }
                }.padding()
            }
        }
    }
}



#Preview {
    BlockedUsers()
}
