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
    @State private var savePost = actionButtons.savePost
    @State private var likePost = actionButtons.unLike
    
    let post : Post
    var user : User
    init(post: Post,user:User) {
        self.post = post
        self.user = user
    }
    var body: some View {
        NavigationStack {
            VStack{
                //User Info
                UserInfo(user: user, imageSize: .xsmall)
                .padding(.horizontal)
                
                //ımage ?? nil
                if let imageUrl = post.imageUrl{
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .frame(width: Const.width * 0.95,height: Const.height * 0.35)
                        .scaledToFill()
                }
                
                // caption
                HStack {
                    if let _ =  post.imageUrl {
                        Text("\(user.username ): ")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        +  Text(post.caption)
                    }
                    else{
                        Text(post.caption)
                    }
                     
                    Spacer()
                }
                .font(.caption)
                .fontWeight(.semibold)
                .padding()
                //action buttons
                HStack{
                    ActionButton(button: likePost,number: 20) {
                        if likePost == .unLike{
                            likePost = .liked
                        }
                        else{
                            likePost = .unLike
                        }
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
                        ActionButton(button: savePost) {
                            if savePost == .savePost{
                                savePost = .savedPost
                            }
                            else{
                                savePost = .savePost
                            }
                                                
                    }
                }
                .padding()
            }
        }
       
        Divider()
    }
}

#Preview {
    FeedViewCell(post: Post.MockData[0], user:  User.MockData[0])
}
