//
//  LikesView.swift
//  HaBu
//
//  Created by mert alp on 16.11.2023.
//

import SwiftUI

struct LikesView: View {
    let post : Post
    init(post: Post) {
        self.post = post
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    HStack{
                        Text("Beğenenler").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text("\(String(post.likeList.count)) beğeni ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }.padding(.bottom , 30)
                    //user.MockData veri tabanından gelen beğenen userlar listesi olacak
                    if post.likeList.count == 0 {
                        Text("Gönderiyi Henüz Kimse Beğenmedi").frame(height: Const.height/2).fontWeight(.bold)
                    }else {
                        ForEach(User.MockData, id: \.id){ user in
                            LikesListTile(user: user)
                    }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    LikesView(post: Post.MockData[0])
}
