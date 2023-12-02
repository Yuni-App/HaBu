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
    @State private var savePost = ActionButtons.savePost
    @State private var likePost = ActionButtons.unLike
    
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
                NavigationLink{
                    ProfileView(user: user)
                }label: {
                    UserInfo(withTime: user, imageSize: .small, timeStamp: "5")
                        .foregroundStyle(.black)

                }
                .navigationBarBackButtonHidden()
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
                    
                    Buttons.actionButton(buttonType: likePost,action: {
                        if likePost == .unLike{
                            likePost = .liked
                        }
                        else{
                            likePost = .unLike
                        }
                    },getNumber: 20)
                    Buttons.actionButton(buttonType:.bubble, action: {
                        showingComment = true
                        print("comment")
                    }, getNumber: 10)
                    .sheet(isPresented: $showingComment) {
                        CommentBottomSheet()
                            .presentationDetents([.large,.medium])
                    }
                    Buttons.actionButton(buttonType: .send) {
                        print("send")
                    }
                    Spacer()
                    Buttons.actionButton(buttonType: savePost) {
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
    FeedViewCell(post: Post.MockData[1], user:  User.MockData[0])
}
