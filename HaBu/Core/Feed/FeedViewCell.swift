//
//  FeedViewCell.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Kingfisher
struct FeedViewCell: View {
    @State private var showingComment = false
    let post : Post
    var user : User
    init(post: Post,user:User) {
        self.post = post
        self.user = user
    }
    var body: some View {
        VStack{
            //User Info
            HStack{
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
                
                
                Spacer()
                Text("4s")
                    .opacity(0.6)
                    .fontWeight(.semibold)
                Button(action: {
                    
                }, label: {
                   Image("3DotHoriizontal")
                        .resizable()
                        .frame(width: 10,height: 15)
                        .padding(.horizontal)
                })
            }
            .padding(.horizontal)
            
            //ımage ?? nil
            if let imageUrl = post.imageUrl{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .frame(width: Const.width * 0.95,height: Const.height * 0.25)
                    .scaledToFill()
            }
            
            // caption
            HStack {
                if let _ =  post.imageUrl {
                    Text("\(user.username ): ")
                        .fontWeight(.semibold)
                    +  Text(post.caption)
                      .font(.caption)
                      .fontWeight(.semibold)
                }
                else{
                    Text(post.caption)
                      .font(.caption)
                      .fontWeight(.semibold)
                }
                 
                Spacer()
            }
            .font(.caption)
            .padding()
            //action buttons
            HStack{
                ActionButton(button: .liked,number: 20) {
                        
                }
                ActionButton(button: .bubble, number: 10) {
                    showingComment = true
                    print("comment")
                    
                }
                .sheet(isPresented: $showingComment) {
                    CommentBottomSheet()
                        .presentationDetents([.large,.medium])
                }
                ActionButton(button: .send) {
                    print("gönder")
                }
                Spacer()
                ActionButton(button: .savePost) {
                    print("kaydet")
                }
            }
            .padding()
            
        }
       
        Divider()
    }
}

#Preview {
    FeedViewCell(post: Post.MockData[0], user:  User.MockData[0])
}
