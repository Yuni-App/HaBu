//
//  UserInfo.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI

struct UserInfo: View {
    @State private var toast: Toast? = nil
    let user:User
    let imageSize : ProfileImageSize
    var timeStamp: String?
    init(withTime user: User, imageSize: ProfileImageSize, timeStamp: String) {
        self.user = user
        self.imageSize = imageSize
        self.timeStamp = timeStamp
    }
    init(user:User,imageSize:ProfileImageSize) {
        self.user = user
        self.imageSize = imageSize
    }
    var body: some View {
        ZStack {
            HStack {
                NavigationLink {
                    ProfileView(user: user)
                } label: {
                    HStack {
                        CircleProfileImage(userIamgeUrl: "", size: imageSize)
                        VStack{
                            Text("\(user.name) \(user.surName)")
                                .fontWeight(.semibold)
                                .font(.caption)
                            Text("\(user.username)")
                                .opacity(0.5)
                                .fontWeight(.semibold)
                                .font(.caption2)
                        }
                        .foregroundStyle(.black)
                    }
                }

                Spacer()
                if timeStamp != nil{
                    Text("4s")
                        .opacity(0.6)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Menu{
                        Button(action: {
                            toast = Toast(style: .warning, message: "Gönderi incelemeye alındı.", width: .infinity)

                        }, label: {
                            Text("Raporla!")
                        })
                        Button(action: {
                            toast = Toast(style: .info, message: "Kişiyi engellemek istediğinize emin misiniz.", width: .infinity)

                        }, label: {
                            Text("Kullanıcıyı Engelle")
                        })
                    }label: {
                        Image.iconManager(.treeDot, size: 15, weight: .regular, color: .black)
                            .rotationEffect(.degrees(90))
                            .padding()

                            
                    }
                }
            }
        }
        .toastView(toast: $toast)
        
    }
}


#Preview {
    UserInfo(withTime : User.MockData[0], imageSize: .small, timeStamp: "12")
}
