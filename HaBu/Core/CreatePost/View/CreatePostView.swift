//
//  CreatePost.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI
struct CreatePostView: View {
    @State private var text: String = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment : .leading) {
                    Text("Medya").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal ,15)
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width , height: 130)
                            .background(
                                Image("")
                                    .resizable()
                                    .foregroundColor(.white).background(Color(red: 1, green: 1, blue: 1).opacity(0.1))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(1), radius: 0, x: 4, y:4)
                            )
                        HStack{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100 , height: 100)
                                    .background(
                                        Image("Mert")
                                            .resizable()
                                            .foregroundColor(.white).background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                                    )
                                CustomImageRectangle(width: 100, height: 100, imagePath: "Mert") .frame(width: 100, height: 100)
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100 , height: 100)
                                    .background(
                                        Image("Mert")
                                            .resizable()
                                            .foregroundColor(.white).background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                                    )
                                CustomImageRectangle(width: 100, height: 100, imagePath: "Mert") .frame(width: 100, height: 100)
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100 , height: 100)
                                    .background(
                                        Image("")
                                            .resizable()
                                            .foregroundColor(.white).background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.9))
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(1), radius: 5, x: 2, y:2)
                                    )
                                CustomImageRectangle(width: 70, height: 70, imagePath: "AddPhoto")
                                
                            }
                        }
                    }
                    
                    //TEXT FİELD
                    VStack {
                               TextField("Ne düşünüyorsunuz?", text: $text)
                                   .padding()
                                   .background(Color.gray.opacity(0.2))
                                   .cornerRadius(10)
                           }
                           .padding()
                    
                                    
                }
            }.toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundStyle(.black)


                    })
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                        
                    }, label: {
                        HStack{
                            Text("Devam").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(Const.primaryColor)
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Const.primaryColor)
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
