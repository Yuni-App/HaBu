//
//  NotificationView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Text("Bildirimler").font(.title).bold()
                        .frame(width: Const.width * 0.4)
                    Spacer()
                }
                Spacer()
                ScrollView {
                    ForEach(Notification.MockData, id : \.id){notification in
                        NavigationLink(destination: ProfilseView(),
                                       label: {
                            HStack(){
                                CircleProfileImage(userIamgeUrl: "\(notification.userProfileImageUrl)", size: .xsmall)
                            }
                            NavigationLink(destination: FeedView(), label: {
                                HStack(){
                                    Text("\(notification.userName) \(notification.status)")
                                    Spacer()
                                    
                                }
                            })
                            NavigationLink(destination: CommentBottomSheet()) {
                                HStack(){
                                    Image(systemName: "star")
                                }
                            }
                            
                        }).frame(width: Const.width * 0.9)
                            .foregroundStyle(.black)
                    }
                }
                
            }
            
        }
    }
}


#Preview {
    NotificationView()
}
