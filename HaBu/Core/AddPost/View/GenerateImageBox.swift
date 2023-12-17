//
//  GenerateImageBox.swift
//  HaBu
//
//  Created by mert alp on 21.11.2023.
//

import SwiftUI

struct GenerateImageBox: View {
    @State private var addPhotoBottomSheet: Bool = false
    let image: AppImage
    var body: some View {
        if (image==(.addPhoto)) {
            Button(action:{
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
                    Text("Kaldır")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                })
            }
        }
    }
}

#Preview {
    GenerateImageBox(image: .mert)
}

struct ImageBox: View {
    let image:AppImage
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: Const.width/4, height: Const.width/4)
                .background(
                    Image.imageManager(image:image ,radius: 7,shadow: Color.black)
                   
                )
        }
    }
}
