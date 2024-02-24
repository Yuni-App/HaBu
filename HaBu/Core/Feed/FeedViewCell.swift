//
//  FeedViewCell.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Kingfisher
struct FeedViewCell: View {
    @Environment(\.dismiss) var dissmis
    @State private var savePost = ActionButtons.savePost
    @State private var likePost = ActionButtons.unLike
    private var backButton : Bool
    @State private var showingComment = false
    @State private var showingLikeList = false
    @Binding var post : Post
    var user : User
    init(post:  Binding<Post>,user:User,likeAction:ActionButtons) {
        self._post = post
        self.user = user
        self.backButton = false
        _likePost = State(initialValue: likeAction)
    }
    init(navigatedWithComment post: Binding<Post>,user:User) {
        self._post = post
        self.user = user
        self.backButton = true
        self.showingComment = true
    }
    init(navigated post:Binding<Post>,user:User){
        self._post = post
        self.user = user
        self.backButton = true

    }
    var body: some View {
            VStack(alignment:.center){
                if backButton {
                    Buttons.backButton {
                        dissmis()
                    }
                    .padding(.trailing,Const.width * 0.9)
                }
                
                Spacer()
                //User Info
                UserInfo(withTime: user, imageSize: .small, timeStamp:post.timeStamp.differenceFromTodayString(), isAnonim: post.isAnonim)
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                
                //ımage ?? nil
                if post.imageUrl.count > 0 {
                    if  post.imageUrl[0] != "" && !(post.imageUrl.isEmpty)
                        {
                            HStack {
                                KFImage(URL(string: post.imageUrl[0]))
                                    .resizable()
                                    .frame(width: Const.width * 0.95,height: Const.height * 0.35)
                                    .scaledToFill()
                            }
                            .frame(width: Const.width)
                            
                        }
                }
                // caption
                HStack {
                    if post.imageUrl.count < 0{
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
                            Task{
                                let value =  try await PostService().likeActionPost(user:AuthService.shared.currentUser!,post:post,like:true,targetUserId: post.userId)
                                  if value{
                                      post.likeList.append(AuthService.shared.currentUser!.id)
                                  }
                            }
                        }
                        else{
                            likePost = .unLike
                            Task{
                                let value =  try await PostService().likeActionPost(user:AuthService.shared.currentUser!,post:post,like:false,targetUserId: post.userId)
                                if value{
                                    post.likeList.removeAll { $0 == AuthService.shared.currentUser!.id }

                                    
                                }
                            }
                        }
                    },getNumber: post.likeList.count,
                    textAction: {
                        showingLikeList = true
                    })
                    .sheet(isPresented: $showingLikeList)
                     {
                         LikesView(userList: post.likeList)
                             .presentationDetents([.large,.medium])
                    }
                    Buttons.actionButton(buttonType:.bubble, action: {
                        
                        showingComment = true
                        
                        
                    },textAction: {
                        showingComment = true
                    })
                    .sheet(isPresented: $showingComment) {
                        CommentBottomSheet(postId: post.id)
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
                HStack{
                    ForEach(post.tags,id: \.self){ tag in
                        HStack(spacing:10){
                            Text("# \(tag)")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 20)
                        .foregroundStyle(.white)
                        .padding(.horizontal,10)
                        .background(
                            Capsule().fill(Const.primaryColor)
                        )
                    }
                    Spacer()
                }
                .padding(.bottom,5)
                Spacer()

            }
            .frame(width: Const.width * 0.98)
            .navigationBarBackButtonHidden(true)
        
    }
}

