//
//  AddFilterView.swift
//  HaBu
//
//  Created by mert alp on 21.11.2023.
//

import SwiftUI

struct AddFilterView: View {
    @State private var isAnonimPost = false
    @State private var isAnonimComment  = false
    var imageList  : [String] = ["Mert","Mert"]
    
    var body: some View {
        NavigationStack{
            
            ScrollView{
                VStack{
                    HStack{
                        VStack(alignment : .leading){
                            //post image
                            HStack{
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(buttonsheet: false, image: userImage)
                                }
                            }.padding(.bottom , 5)
                            HStack{
                                Text("bu kısım post hakkında kısmıdır. halısahaya bir rakip arıyoruz kendine güvenene takımlar bana ulaşsın ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .padding()
                        .frame(width: Const.width)
                        .background( RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.gray.opacity(0.2)))
                        
                    }
                    //filtre
                    //veriler geldiğinde update gerekiyor
                    HStack{
                        FiltreRow(firstCategory: "kiralık ev", secondCategory: "oda")
                        Spacer()
                        FiltreRow(firstCategory: "ders notu", secondCategory: "ikinci el")
                        Spacer()
                        FiltreRow(firstCategory: "güzel kız", secondCategory: "itiraf")
                    }.frame(width: Const.width,height: Const.height/8)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.gray.opacity(0.2)))
                    
                    //anonim gönderi
                    HStack{
                        Toggle("Anonim Gönderi", isOn: $isAnonimPost)
                            .padding()
                            .fontWeight(.bold)
                    }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.gray.opacity(0.2)))
                    
                    //anonim yorum
                    HStack{
                        Toggle("Anonim Yorum", isOn: $isAnonimComment)
                            .padding()
                            .fontWeight(.bold)
                    }.padding()
                        .background( RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.gray.opacity(0.2)))
                    HStack{
                        Text("Uygulanan Filtreler Sonradan Değiştirilemez ").foregroundColor(.red).padding()
                    }
                    
                }.frame(width: Const.width)
                
            }.toolbar{
                NavigationStack{
                    NavigationLink {
                        FeedView().navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
                            Text("Paylaş")
                                .fontWeight(.bold)
                                .foregroundColor(Const.primaryColor)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(Const.primaryColor)
                        }
                    }
                    
                }
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

struct FiltreRow: View {
    var  firstCategory  : String
    var  secondCategory : String
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                CheckBoxView(checked: false) {
                }
                Text(firstCategory)
            }
            HStack{
                CheckBoxView(checked: false) {
                }
                Text(secondCategory)
            }
        }.padding(.leading , 15)
            .frame(width:Const.width/3)
    }
}
