//
//  NotificationView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Firebase

struct NotificationView: View {
    @StateObject var  notificationVM = NotificationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
               
                HStack{
                    Text("Bildirimler")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ZStack {
                    ScrollView{
                        HStack(){
                            Image(systemName: "horn.blast.fill")
                                .foregroundStyle(.red)
                            Text("3 Bildirim")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal,15)
                        
                        ForEach(notificationVM.notifications) { notification in
                            NotificationCell(notification: notification)
                            Divider()
                        }
                        
                        
                        HStack{
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.blue)
                            Text("Eski Bildirimler")
                            Spacer()
                        }
                        .padding(.horizontal,15)
                        /*
                         ForEach(0..<7){i in
                             NotificationCell(notification: Notification.MOCK_DATA[i])
                             Divider()
                         }
                         */
                        
                    }
                    .zIndex(1)
                    Const.backgroundColor.zIndex(0)
                }
            }
        }
        
    }
    @ViewBuilder
    func NotificationCell(notification:Notification)-> some View{
        
        NavigationLink{
            if notification.type == ""{
                FeedViewCell(navigated : notification.post ?? Post.MockData[0], user: notification.user ?? User.MockData[0])
            }
            else if notification.type == "" {
                FeedViewCell(navigatedWithComment: notification.post ?? Post.MockData[0], user: notification.user ?? User.MockData[0])
            }
            else if notification.type == ""{
                FeedViewCell(navigatedWithComment: notification.post ?? Post.MockData[0], user: notification.user ?? User.MockData[0])
            }
        }label: {
            HStack{
                CircleProfileImage(userIamgeUrl: "", size: .small)
                VStack (alignment:.leading){
                    Text(User.MockData[0].username)
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.footnote)
                        .fontWeight(.bold)
                    Text("Gönderinizi Beğendi")
                        .font(.headline)
                        .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
                
                Spacer()
                VStack{
                    HStack{
                        Image(systemName: "clock.fill")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                        Text(formattedDate(from: notification.createdAt))
                            .font(.caption2)
                            .foregroundColor(.black)
                            .font(.caption2)
                            .foregroundStyle(.black)
                        
                    }
                    Spacer()
                }
                .padding(3)
                
            }
            .padding(.horizontal,10)
            .frame(width: Const.width * 0.95,height: Const.height * 0.1)
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 5, style: .circular))
            .shadow(color: Color.black.opacity(0.4), radius: 3, x: 0, y:3)
            
        }
    }
}
func formattedDate(from timestamp: Timestamp) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    return dateFormatter.string(from: date)
}


#Preview {
    NotificationView()
}

