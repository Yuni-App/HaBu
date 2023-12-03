//
//  UserInfo.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI

struct UserInfo: View {
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
        NavigationStack {
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
                    
                    
                Spacer()
                if timeStamp != nil{
                Text("4s")
                    .opacity(0.6)
                    .font(.footnote)
                    .fontWeight(.semibold)
                Button(action: {
                    
                }, label: {
                    Image("3DotHoriizontal")
                        .resizable()
                        .frame(width: 10,height: 15)
                        .padding(.horizontal)
                })
            }
            }
        }
    }
}


#Preview {
    UserInfo(user: User.MockData[0], imageSize: .small)
}
