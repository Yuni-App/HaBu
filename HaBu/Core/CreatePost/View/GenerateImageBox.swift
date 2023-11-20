//
//  GenerateImage.swift
//  HaBu
//
//  Created by mert alp on 20.11.2023.
//

import SwiftUI

struct GenerateImageBox: View {
    @State private var addPhotoBottomSheet: Bool = false
    let buttonsheet : Bool
    let image: String

    var body: some View {
        if (buttonsheet) { Button(action:
        {
            addPhotoBottomSheet = true
        }, label: {
            VStack{
                ImageBox(image: image).sheet(isPresented: $addPhotoBottomSheet) {
                    AddImageBottomSheet()
                }
                Text(" ")
                .font(.system(size: 15))

            }
           
        })}else{
            VStack{
                ImageBox(image: image)
                Button(action: {
                    //image delete
                }, label: {
                    Text("kaldır")
                        .foregroundColor(.black)
                    .font(.system(size: 15))
                })
           
            }
        }
    }
}

#Preview {
    GenerateImageBox(buttonsheet: false, image: "Mert")
}

struct ImageBox: View {
    let image: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: Const.width/4, height: Const.width/4)
                .background(
                    Image(image)
                        .resizable()
                        .foregroundColor(.white)
                        .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                        .cornerRadius(6)
                        .shadow(color: Color.black.opacity(1), radius: 5, x: 3, y: 3)
                )
          
        }
    }
}
