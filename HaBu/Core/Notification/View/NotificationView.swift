//
//  NotificationView.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI
import Firebase

struct NotificationView: View {
    @StateObject var  notificationVM = NotificationViewModel.shared
    
    var body: some View {
        
            VStack {
               
                HStack{
                    Text("Bildirimler")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ZStack {
                    ScrollView{
                        if(notificationVM.newNotificaitons.count != 0 ){
                            HStack(){
                                Image(systemName: "horn.blast.fill")
                                    .foregroundStyle(.red)
                                Text("\($notificationVM.newNotificaitons.count) Yeni Bildirim")

                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.horizontal,15)
                        }
                        
                        
                        ForEach(notificationVM.newNotificaitons) { notification in
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
                        ForEach(notificationVM.notificationsData) { notification in
                            NotificationCell(notification: notification)
                            Divider()
                        }
                       
                        
                    }
                    .zIndex(1)
                    Const.backgroundColor.zIndex(0)
                }
            }.onAppear {
                // View görüntülendiğinde bildirimleri dinlemeye başla
             //   Task{
              //   await   notificationVM.listenForNotifications()
              //  }
            }
            .onOpenURL(perform: { url in
                print(url)
            })
            .onDisappear {
                notificationVM.exitPage()
            }
        
    }
    @ViewBuilder
    func NotificationCell(notification:NotificationData)-> some View{
        
        NavigationLink{

            if notification.type == ""{
              //  FeedViewCell(navigated : notification.post ?? Post.MockData[0], user: notification.user ?? User.MockData[0])
            }
            else if notification.type == "" {
             //   FeedViewCell(navigatedWithComment: notification.post ?? Post.MockData[0], user: notification.user ?? User.MockData[0])
            }
            else if notification.type == ""{
                //FeedViewCell(navigatedWithComment: notification.post ?? Post.MockData[0], user: notification.user ?? User.MockData[0])

            }
        }label: {
            HStack{
             

                if let profileImageUrl = notification.user?.profileImageUrl?.first {
                    CircleProfileImage(userIamgeUrl: profileImageUrl, size: .small)
                } else {
                    // Eğer profiil resmi URL'si mevcut değilse, varsayılan bir resim gösterilebilir.
                    CircleProfileImage(userIamgeUrl: "", size: .small)
                }
                VStack (alignment:.leading){
                    Text(notification.user?.username ?? "Hata")
                        .foregroundStyle(.black.opacity(0.7))
                        .font(.footnote)
                        .fontWeight(.bold)
                    Text(notification.type == NotificationType.postLike.rawValue  ?  "Gönderinizi Beğendi" : "Gönderinize Yorum Attı")
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
