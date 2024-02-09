//
//  LikesView.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct LikesView: View {
   
    let userListString : [String]
    @StateObject var likesVM : LikesViewModel
    init(userList: [String]) {
        self.userListString = userList
        self._likesVM = StateObject(wrappedValue: LikesViewModel(userListString: userList))
    }
    
    
    var body: some View {
        
        VStack {
            HStack{
               
                Text("Beğenenler").fontWeight(.bold)
                Spacer()
                Text("\(String(userListString.count)) beğeni ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }.padding(.bottom , 30)
            ScrollView{
                VStack{
                    if userListString.count == 0 {
                        Text("Bu gönderiyi henüz kimse beğenmedi").frame(height: Const.height/2).fontWeight(.bold)
                    }else {
                        ForEach(likesVM.likeUsersList, id: \.id){ user in
                            LikesListTile(user: user)
                            Divider()
                        }
                        
                    }
                    
                }
            }.padding()
                .navigationBarBackButtonHidden(true)
            
        }
    }
}
#Preview {
    LikesView(userList: [])
}
