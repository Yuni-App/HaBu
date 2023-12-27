//
//  BlockedUsers.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI

struct BlockedUsersView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var blockedUsersVM : BlockedUsersViewModal
    init(){
        self._blockedUsersVM = StateObject(wrappedValue: BlockedUsersViewModal())
    } 
    
    var body: some View {
            VStack{
                CustomSettingsTollBar(action: {
                    dismiss()
                }, title: "Engellenenler", blockedCount:  blockedUsersVM.blockedList.count)
                ScrollView{
                    VStack{
                        if blockedUsersVM.blockedList.count == 0 {
                            Text("Engellenenler Listeniz Boş").frame(height: Const.height/2).fontWeight(.bold)
                        }else {
                            ForEach(blockedUsersVM.blockedList, id: \.id){ user in
                                blockedUserListTile(user: user)
                                Divider()
                        }
                        }
                    }
                }.frame(width: Const.width)
                    .background(
                        Const.primaryBackGroundColor
                )
            }.navigationBarBackButtonHidden(true)
            .onAppear {
                       // Sayfa yüklendiğinde fetchBlockedList fonksiyonunu çağır
                       blockedUsersVM.fetchBlockedList()
                   }
    }
}


#Preview {
    BlockedUsersView()
}

@ViewBuilder
private func blockedUserListTile(user : User)->some View {
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
            Buttons.customButton(title:"Kaldır" , buttonColor: Const.primaryButtonColor,size: .xxxsmall) {
            }
        }.padding(.horizontal ,15)
        .padding(.vertical,5)
    
}



