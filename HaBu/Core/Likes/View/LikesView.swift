//
//  LikesView.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct LikesView: View {
   
    let post : Post
    @StateObject var likesVM : LikesViewModel
    init(post: Post) {
        self.post = post
        self._likesVM = StateObject(wrappedValue: LikesViewModel())
    }
    
    
    var body: some View {
        
        VStack {
            HStack{
               
                Text("Beğenenler").fontWeight(.bold)
                Spacer()
                Text("\(String(post.likeList.count)) beğeni ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }.padding(.bottom , 30)
            ScrollView{
                VStack{
                    if post.likeList.count == 0 {
                        Text("Gönderiyi Henüz Kimse Beğenmedi").frame(height: Const.height/2).fontWeight(.bold)
                    }else {
                        ForEach(likesVM.likeUsersList, id: \.id){ user in
                            LikesListTile(user: user)
                            Divider()
                        }
                        
                    }
                    
                }
            }.padding()
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    likesVM.fetchLikesUserList(userIdList: ["useridlist"])
                }
            
        }
    }
}
#Preview {
    LikesView(post: Post.MockData[0])
}
