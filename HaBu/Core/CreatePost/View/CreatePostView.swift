//
//  CreatePostView.swift
//  HaBu
//
//  Created by mert alp on 21.11.2023.
//

import SwiftUI

struct CreatePostView: View {
    var imageList  : [String] = ["Mert"]
    @State private var text: String = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment : .leading) {
                    Text("Medya").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal ,15)
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width , height: Const.height/6)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray.opacity(0.2))
                            )
                        HStack{
                            if imageList.isEmpty {
                                GenerateImageBox(buttonsheet: false, image: "AddPhoto" )
                            }
                            if imageList.count == 3 {
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(buttonsheet: false, image: userImage)
                                 }
                            }
                            if imageList.count == 2 {
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(buttonsheet: false, image: userImage)
                                   
                                 }
                                GenerateImageBox(buttonsheet: true, image: "AddPhoto")
                            }
                            if imageList.count == 1 {
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(buttonsheet: false, image: userImage)
                                 }
                                GenerateImageBox(buttonsheet: true, image: "AddPhoto")
                            }
                        }
                    }
                    Text("İçerik").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal ,15).padding(.top , 20)
                    
                    //TEXT FİELD
                    VStack {
                               TextField("Ne düşünüyorsunuz?", text: $text, axis: .vertical)
                                   .padding()
                                   .lineLimit(10...)
                                   .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                    }   .padding(.horizontal , 10)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    }, label: {
                        NavigationLink(destination: AddFilterView()) {
                            HStack{
                                Text("Devam")
                                    .fontWeight(.bold)
                                    .foregroundColor(Const.primaryColor)
                                Image(systemName: "chevron.right.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(Const.primaryColor)
                            }
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    CreatePostView()
}



