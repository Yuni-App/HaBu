//
//  CreatePost.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI

struct CreatePost: View {
    @State private var text: String = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Medya").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    HStack{
                        CustomImageRectangle(width: 100, height: 100, imagePath: ImageManager.registerThirdVector)
                        CustomImageRectangle(width: 100, height: 100, imagePath: ImageManager.registerThirdVector)
                        CustomImageRectangle(width: 100, height: 100, imagePath: ImageManager.registerThirdVector)
                    }.padding()
                    //TextField(text: $text, label : Text("Ne Düşünüyorsunuz ? "))
                  
                       
                }.padding()
            }
        }
    }
}

#Preview {
    CreatePost()
}
