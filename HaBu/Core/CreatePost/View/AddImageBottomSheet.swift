//
//  AddImageBottomSheet.swift
//  HaBu
//
//  Created by mert alp on 21.11.2023.
//


import SwiftUI

struct AddImageBottomSheet: View {
    var body: some View {
        ZStack {
            Image("")
            .frame(width: Const.width , height: 300)
            .background(Const.primaryColor.opacity(0.4))
            .cornerRadius(10)
            

            VStack{
                Button(action: {}, label: {
                    HStack{
                        Image(systemName: "camera")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                        Text("Kamera")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                    .frame(width: Const.width,height: Const.height/14)
                    .background(.gray.opacity(0.1))
                    
                    
                }
                )
                Button(action: {}, label: {
                    HStack{
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                        Text("Galeri")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
                    }
                    .frame(width: Const.width,height: Const.height/14)
                    .background(.gray.opacity(0.1))
                    
                    
                }
                )
            }
            
            .frame(width: Const.width)
        .presentationDetents([.height(CGFloat(Const.height/5)),.height(CGFloat(Const.height/6))])
        }
    }
    
}

#Preview {
    AddImageBottomSheet()
}
