//
//  3DRotateFeedViewCell.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI
import Kingfisher

struct ThreeDRotateFeedViewCell: View {
    @State private var showingComment = false
    @State private var savePost = actionButtons.savePost
    @State private var likePost = actionButtons.unLike
    @State private var degrees: Double = 0.0
    @State private var isFlipped: Bool = false
   @State private var dragDirection: DragDirection = .none
    
    let post : Post
    var user : User
    init(post: Post,user:User) {
        self.post = post
        self.user = user
    }
    var body: some View {
        
        VStack {
            UserInfo(user: user, imageSize: .xsmall)
            .padding(.horizontal)
            .frame(height:  Const.height * 0.1)
            ZStack {
                //Image
                VStack{
                    if let imageUrl = post.imageUrl{
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .frame(width: Const.width * 0.95,height: Const.height * 0.35)
                            .scaledToFill()
                    }
                    
                }.opacity(isFlipped ? 0.0 : 1.0)
                
                //Caption
                VStack{
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
                }
                .opacity(isFlipped ? 1.0 : 0.0)
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            }
            .rotation3DEffect(
                .degrees(degrees),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .gesture(DragGesture().onChanged({ value in
                let direction: DragDirection = value.translation.width > 0 ? .right : .left
                if dragDirection != direction{
                    withAnimation{
                        dragDirection = direction
                        degrees += dragDirection == .left ? -180:180
                        isFlipped.toggle()
                    }
                }
        }))
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
            Divider()
                .frame(height: 2)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ThreeDRotateFeedViewCell(post: Post.MockData[0], user: User.MockData[0])
}
enum DragDirection {
    case none
    case right
    case left
}
