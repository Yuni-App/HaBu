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
    var body: some View {
        NavigationStack {
            HStack {
                VStack{
                    NavigationLink{
                        ProfileView(user: User.MockData[0])
                    }label: {
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


#Preview {
    UserInfo(user: User.MockData[0], imageSize: .xsmall)
}
