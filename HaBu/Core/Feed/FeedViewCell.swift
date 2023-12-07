//
//  FeedViewCell.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Kingfisher

struct FeedViewCellData:Hashable {
    var post:Post
    var user:User
    var showComment = false
}

struct FeedViewCell: View {
    @State var showingComment : Bool
    @State private var savePost = ActionButtons.savePost
    @State private var likePost = ActionButtons.unLike
    @EnvironmentObject var navigation:NavigationStateManager
    @State var data : FeedViewCellData
   
    
    init(data:FeedViewCellData) {
        self.data = data
        showingComment = data.showComment
       
       
        
    }
    var body: some View {
            VStack(alignment:.center){
               //Task : Back Button
                
                
                Spacer()
                //User Info
                Button(action: {
                    navigation.push(.profile(.profile))
                    
                }, label: {
                    UserInfo(withTime: data.user, imageSize: .small, timeStamp: "5")
                        .foregroundStyle(.black)
                })
                .navigationBarBackButtonHidden()
                .padding(.horizontal)
                
                //ımage ?? nil
                if let imageUrl = data.post.imageUrl{
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .frame(width: Const.width * 0.95,height: Const.height * 0.35)
                        .scaledToFill()
                }
                // caption
                HStack {
                    if let _ =  data.post.imageUrl {
                        Text("\(data.user.username ): ")
                            .fontWeight(.bold)
                            .font(.subheadline)
                        +  Text(data.post.caption)
                    }
                    else{
                        Text(data.post.caption)
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
                Spacer()
            }
        
    }
}
#Preview {
    FeedViewCell(data:FeedViewCellData(post: Post.MockData[0], user:  User.MockData[0]))
}
