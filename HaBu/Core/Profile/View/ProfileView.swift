//
//  Profile.swift
//  HaBu
//
//  Created by yusuf on 15.11.2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            
            HStack{
                CircleProfileImage(userIamgeUrl: "", size: .xlage)
                    .frame(width: 80).padding()
                VStack {
                    Text("Yusuf Aydın")
                        .font(.title2)
                    Text("MMF/bilgisayar").font(.subheadline)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("145").font(.subheadline)
                    }
                }
                Spacer()
                
                
                
                VStack{
                    Spacer()
                    Text("4 Post").frame(width: 75, height: 20).padding(.vertical, 4).padding(.horizontal, 8)
                    Spacer()
                    Button {
                        print("tapped")
                    } label: {
                        Spacer()
                        Text("< Edit").font(.headline).foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .frame(height: 43)
                            .background(Color.white)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 20,
                                    bottomLeadingRadius: 20,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 0
                                )
                            )
                    }.frame(width: 100, height: 55)
                }
                
                
            }.frame(height: 200)
                .background(Color(red: 0.33, green: 0.74, blue: 0.72))
            
            Spacer()
            VStack{
                Text("dsadasda")
            }
            
        }
    }
}

#Preview {
    ProfileView()
}
