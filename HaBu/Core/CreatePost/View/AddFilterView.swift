//
//  AddFilterView.swift
//  HaBu
//
//  Created by mert alp on 18.11.2023.
//

import SwiftUI

struct AddFilterView: View {
    @State private var isAnonimPost = false
    @State private var isAnonimComment  = false
    var body: some View {
        NavigationStack{
            
            ScrollView{
                VStack{
                    HStack{
                        VStack(alignment : .leading){
                            //post image
                            HStack{
                                //update
                                GenerateImageBox(image: "Mert")
                                GenerateImageBox(image: "Mert")
                                GenerateImageBox(image: "Mert")

                            }.padding(.bottom , 5)
                            HStack{
                                Text("bu kısım post hakkında kısmıdır. halısahaya bir rakip arıyoruz kendine güvenene takımlar bana ulaşsın ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .padding()
                        .frame(width: Const.width)
                        .background( RoundedRectangle(cornerRadius: 20) // Oval şeklinde kenarlıklar ekleniyor
                            .foregroundColor(Color.gray.opacity(0.2)))
                           
                        }
                    HStack{
                        Toggle("Anonim Gönderi", isOn: $isAnonimPost)
                            .padding()
                            .fontWeight(.bold)
                    }.padding()
                    .background( RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.gray.opacity(0.2)))
                    HStack{
                        Toggle("Anonim Yorum", isOn: $isAnonimComment)
                            .padding()
                            .fontWeight(.bold)
                    }.padding()
                    .background( RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.gray.opacity(0.2)))
                    
                    HStack{
                        VStack{
                            HStack{
                                CheckBoxView(checked: false) {
                                }
                                Text("ev")
                            }
                            HStack{
                                CheckBoxView(checked: false) {
                                }
                                Text("ev")
                            }
                        }
                        VStack{
                            HStack{
                                CheckBoxView(checked: false) {
                                }
                                Text("ev")

                            }
                            HStack{
                                
                                CheckBoxView(checked: false) {
                                }
                                Text("ev")
                            }
                        }
                        VStack{
                            HStack{
                               
                                CheckBoxView(checked: false) {
                                }
                                Text("e v")
                            }
                            HStack{
                               
                                CheckBoxView(checked: false) {
                                }
                                Text("ev")
                            }
                        }
                    }.frame(width: Const.width,height: Const.height/8).background(RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.gray.opacity(0.2)))
                }.frame(width: Const.width)
               
                }
            }.toolbar{
               
                ToolbarItem(placement: .topBarTrailing) {
                    Text("Tamamla").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(Const.primaryColor)
                }
            }
           
        }
}
#Preview {
    AddFilterView()
}



/*
 
 
}
 */
