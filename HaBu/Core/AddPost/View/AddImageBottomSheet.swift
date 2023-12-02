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
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: Const.height * 4 / 10)
                .background(
                    Color.white
                )
            HStack{
                Spacer()
                VStack{
                    Image(systemName: "camera")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(UIColor(hex: "04243E")))
                        .cornerRadius(7)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    Text("Kamera")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                }
                Spacer()
                VStack{
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(UIColor(hex: "04243E")))
                        .cornerRadius(7)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    Text("Galeri")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 25))
                }
                Spacer()
            }
            .frame(width: Const.width)
        .presentationDetents([.height(CGFloat(Const.height/4)),.height(CGFloat(Const.height/6))])
        }
    }
    
}

#Preview {
    AddImageBottomSheet()
}
