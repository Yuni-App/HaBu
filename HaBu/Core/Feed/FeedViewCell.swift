//
//  FeedViewCell.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Kingfisher
struct FeedViewCell: View {
    let post : Post
    var user : User
    init(post: Post) {
        self.post = post
        user = User.MockData[0]
    }
    var body: some View {
        VStack{
            //User Info
            HStack{
                CircleProfileImage(userIamgeUrl: "", size: .small)
                VStack{
                    Text("\(user.name) \(user.surName)")
                        .fontWeight(.semibold)
                    Text("\(user.username)")
                        .opacity(0.5)
                        .fontWeight(.semibold)
                        .font(.callout)
                }
                
                .padding(.horizontal)
                
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
                Text("\(user.username): ")
                    .fontWeight(.semibold) +
                    Text(post.caption)
            }
            .font(.caption)
            //action buttons
            HStack{
                Button(action: {
                    
                }, label: {
                    actionButtonLabel(button: .like,number: 10)
                    
                })
                Button(action: {
                    
                }, label: {
                    actionButtonLabel(button: .bubble,number: 4)
                    
                })
                Button(action: {
                    
                }, label: {
                    actionButtonLabel(button: .send)
                    
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    actionButtonLabel(button: .savePost)
                    
                })
            }
            .padding()
            
        }
    }
}

#Preview {
    FeedViewCell(post: Post.MockData[0])
}
