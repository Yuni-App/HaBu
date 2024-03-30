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
        ZStack{
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
                            .padding(.horizontal,7)
                        }
                        
                        
                        ForEach(notificationVM.newNotificaitons) { notification in
                            NotificationCell(notification: notification)
                            Divider()
                        }

                        
                        HStack{
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.blue)
                            Text("Eski Bildirimler")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal,7)
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
            
            if notificationVM.isLoading  {
                    VStack (alignment:.center){
                        VStack(spacing:20){
                            ZStack{
                                ProgressView()
                            }
                            Text(" Yükleniyor..")
                        }.padding()
                        .background(.white)
                        .cornerRadius(10)
                       
                    }
                 
                    .background(Color.gray.opacity(0.1)) // Opak gri arka plan
                
            }
        }
           
        
    }
    @ViewBuilder
    func NotificationCell(notification:NotificationData)-> some View{
        
        NavigationLink{
          //  FeedViewCell(navigatedWithComment: notification. ?? Post.MockData[0], user: notification.user ?? User.MockData[0])

          //  FeedViewCell(post:notification.post,user: notification.user! ,likeAction: checkLike(post: notification.post!, userID: AuthService.shared.currentUser!.id))

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
                        .fontWeight(.bold)
                        .font(.system(size: 17))
                        .foregroundStyle(.black)
                    Text(notification.type == NotificationType.postLike.rawValue  ?  "Gönderinizi Beğendi" : "Gönderinize Yorum Attı")
                        .fontWeight(.semibold)
                        .font(.system(size: 15))
                    .foregroundStyle(.black)
                    HStack(spacing:1) {
                        Image(systemName: "clock.fill")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                        Text(formattedDate(from: notification.createdAt))
                            .font(.caption2)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                VStack{
                
                    if let notificationImageUrl = notification.post!.imageUrl.first {
                        CircleProfileImage(userIamgeUrl: notificationImageUrl, size: .small)
                    }else {
                        // Eğer profiil resmi URL'si mevcut değilse, varsayılan bir resim gösterilebilir.
                       Spacer()
                    }
                    
                }
               
            }
            .padding(.horizontal,12)
            
        }
    }
}
func formattedDate(from timestamp: Timestamp) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp.seconds))
    let currentDate = Date()

    let secondsAgo = Int(currentDate.timeIntervalSince(date))
    let minutesAgo = secondsAgo / 60
    let hoursAgo = minutesAgo / 60
    let daysAgo = hoursAgo / 24
    let monthsAgo = daysAgo / 30
    
    if secondsAgo < 60 {
        return "Şimdi"
    } else if minutesAgo <= 60 {
        return "\(minutesAgo) dakika önce"
    } else if hoursAgo <= 24 {
        return "\(hoursAgo) saat önce"
    } else if daysAgo < 30 {
        return "\(daysAgo) gün önce"
    } else {
        return "\(monthsAgo) ay önce"
    }
}



#Preview {
    NotificationView()
}
