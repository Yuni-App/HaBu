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
    @State private var savePost = ActionButtons.savePost
    @State private var likePost = ActionButtons.unLike
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
            UserInfo(user: user, imageSize: .small)
            .padding(.horizontal)
            .frame(height:  Const.height * 0.1)
            ZStack {
                //Image
                VStack{
                    if let imageUrl = post.imageUrl{
                        KFImage(URL(string: imageUrl[0]))
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
                let direction: DragDirection = value.translation.width > 200 ? .right : .left
                withAnimation(.smooth){
                    dragDirection = direction
                    degrees += (value.translation.width / 100)
                    degrees = degrees == 360 ? 0 : degrees
                }
        })
                .onEnded({ _ in
                        withAnimation{
                            if degrees > 0 {
                                degrees += (degrees + 180)
                            }
                            else{
                                degrees = -180
                            }
                            
                            isFlipped.toggle()
                        }
                    }
                )
            )
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
            Divider()
                .frame(height: 2)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ThreeDRotateFeedViewCell(post: Post.MockData[0], user: User.MockData[0])
}

