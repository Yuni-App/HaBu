//
//  AddImageBottomSheet.swift
//  HaBu
//
//  Created by mert alp on 21.11.2023.
//


import SwiftUI

struct AddImageBottomSheet: View {
    var body: some View {
            HStack{
                Spacer()
                bottomSheetItem(text: "Kamera", icon: .camera)
                Spacer()
                bottomSheetItem(text: "Galeri", icon: .gallery)
                Spacer()
            }
            .frame(width: Const.width)
            .presentationDetents([.height(CGFloat(Const.height/4)),.height(CGFloat(Const.height/6))])
    }
    
}

@ViewBuilder
func bottomSheetItem(text:String ,icon : AppIcon )-> some View {
    Button(action: {
        //open galery or camera
    }, label: {
        VStack{
            Image.iconManager(icon, size: 50, weight: .bold, color: .white).padding()
                .background(Color(UIColor(hex: "04243E")))
                .cornerRadius(7)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            Text(text)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.system(size: 25))
        }
    })
}


#Preview {
    AddPostView()
}
