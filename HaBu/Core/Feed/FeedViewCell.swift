//
//  FeedViewCell.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Kingfisher
struct FeedViewCell: View {
    @State var showingComment : Bool
    @State private var savePost = ActionButtons.savePost
    @State private var likePost = ActionButtons.unLike
    @Binding var hideTab:Bool
    private var backButton : Bool
    let post : Post
    var user : User
    init(post: Post,user:User,hideTab:Binding<Bool>) {
        self.post = post
        self.user = user
        self.showingComment = false
        self.backButton = false
        _hideTab = hideTab
    }
    init(navigatedWithComment post: Post,user:User) {
        self.post = post
        self.user = user
        self.showingComment = true
        self.backButton = true
        _hideTab = .constant(false)
    }
    init(navigated post:Post,user:User){
        self.post = post
        self.user = user
        self.showingComment = false
        self.backButton = true
        _hideTab = .constant(false)

    }
    var body: some View {
            VStack(alignment:.center){
                if backButton {
                    Buttons.backButton {
                            
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                //User Info
                NavigationLink{
                    ProfileView(hideTab: $hideTab, user: user)
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
                Spacer()
            }
        
    }
}
#Preview {
    FeedViewCell(post: Post.MockData[0], user:  User.MockData[0], hideTab: .constant(false))
}
