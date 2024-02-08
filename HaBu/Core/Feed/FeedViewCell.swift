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
    let post : Post
    var user : User
    init(post: Post,user:User) {
        self.post = post
        self.user = user
        self.backButton = false
        
    }
    init(navigatedWithComment post: Post,user:User) {
        self.post = post
        self.user = user
        self.backButton = true
        self.showingComment = true
    }
    init(navigated post:Post,user:User){
        self.post = post
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
                UserInfo(withTime: user, imageSize: .small, timeStamp: post.timeStamp.differenceFromTodayString())
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
                        }
                        else{
                            likePost = .unLike
                        }
                    },getNumber: post.likeList.count,
                    textAction: {
                        showingLikeList = true
                    })
                    .sheet(isPresented: $showingLikeList)
                     {
                         LikesView(post: Post.MockData[0])
                             .presentationDetents([.large,.medium])
                    }
                    Buttons.actionButton(buttonType:.bubble, action: {
                        showingComment = true
                        print("comment")
                    }, getNumber: post.likeList.count)
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
                Spacer()
                Divider()

            }
            .frame(width: Const.width * 0.98)
            .navigationBarBackButtonHidden(true)
        
    }
}
#Preview {
    FeedViewCell(navigatedWithComment: Post.MockData[0], user: User.MockData[0])
}

/*
 import Firebase

 struct FeedViewCell: View {

   @Environment(\.dismiss) var dissmis
   @State private var savePost = ActionButtons.savePost
   @State private var likePost = ActionButtons.unLike
   private var backButton : Bool
   @State private var showingComment = false
   @State private var showingLikeList = false
   let post : Post
   var user : User

   init(post: Post,user:User) {
     self.post = post
     self.user = user
     self.backButton = false
   }
   init(navigatedWithComment post: Post,user:User) {
     self.post = post
     self.user = user
     self.backButton = true
     self.showingComment = true
   }
   init(navigated post:Post,user:User){
     self.post = post
     self.user = user
     self.backButton = true

   }


           Buttons.actionButton(buttonType: likePost,action: {
                   if likePost == .unLike{
                       likePost = .liked
                       // Firebase Function'ı çağır
                       Functions.functions().httpsCallable("updateLikeCount")             .call([
                       "postId": post.id,
                       "isLiked": true,
                       ]) { result, error in
                       // Sonucu veya hatayı ele alın
                       if let result = result as? [String: Any]{
                           if let likeCount = result["likeCount"] as? Int{
                           self.likeNumber = likeCount
                           }
                       }
                       }
                   }
                   else{
                        likePost = .unLike
                        // Firebase Function'ı çağır
                        Functions.functions().httpsCallable("updateLikeCount")           .call([
                          "postId": post.id,
                          "isLiked": false,
                        ]) { result, error in
                          // Sonucu veya hatayı ele alın
                          if let result = result as? [String: Any]{
                            if let likeCount = result["likeCount"] as? Int{
                              self.likeNumber = likeCount
                            }
                          }
                        }
                      }
                    },getNumber: likeNumber, textAction: {
                      showingLikeList = true
                     })
                    
                  }
                }
           .sheet(isPresented: $showingLikeList)
           {
             LikesView(post: Post.MockData[0])
             .presentationDetents([.large,.medium])
           }
 */
