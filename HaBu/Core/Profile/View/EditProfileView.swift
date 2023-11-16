//
//  EditProfileView.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        
        VStack {
            
            Text("HaBu")
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("150").frame(height: 45)
            }
            
            
            Spacer()
            
            HStack {
                VStack {
                    Text("İsim").bold()
                    Text("dsada").frame(width: 300,height: 30)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            
            HStack {
                VStack {
                    Text("Soyisim").bold()
                    Text("dsada").frame(width: 300,height: 30)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            
            HStack {
                VStack {
                    Text("Email").bold()
                    Text("dsada").frame(width: 300,height: 30)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            HStack{
                VStack{
                    Text("Biograif").bold()
                    Text("bir ben var benden öte benden ziyade").frame(width: 300, height: 50)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {}, label: {
                    Text("Kaydet")
                        .frame(width: 100,height: 30)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(5)
                    
                })
            }
        }.background(Color(red: 0.33, green: 0.74, blue: 0.72))
    }
}

#Preview {
    EditProfileView()
}
