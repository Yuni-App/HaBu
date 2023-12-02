//
//  SettingsView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            VStack{
                ExtractedView()
                VStack{
                    ScrollView{
                        VStack{
                            Text("Kullanıcı Bilgileri").frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black.opacity(0.7))
                                .fontWeight(.bold)
                            VStack{
                                SettingsTile(image: "person.crop.circle", text: "Profili Düzenle")
                                Divider().frame(width: Const.width * 0.84)
                                SettingsTile(image: "person.crop.circle", text: "Profili Düzenle")
                                Divider().frame(width: Const.width * 0.84)
                                SettingsTile(image: "person.crop.circle", text: "Profili Düzenle")
                                Divider().frame(width: Const.width * 0.84)
                                SettingsTile(image: "person.crop.circle", text: "Profili Düzenle")
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    .white
                                ).cornerRadius(7)
                              

                        }.shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
                        VStack{
                            Text("Bilgi").frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black.opacity(0.7))
                                .fontWeight(.bold)
                            VStack{
                                SettingsTile(image: "person.crop.circle", text: "Geri Bildirim")
                                Divider().frame(width: Const.width * 0.84)
                                SettingsTile(image: "person.crop.circle", text: "Gizlilik Sözleşmesi")
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    .white
                                ).cornerRadius(7)
                        }  .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
                            .padding(.top , 5)
                        VStack{
                            Text("Diğer").frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black.opacity(0.7))
                                .fontWeight(.bold)
                            VStack{
                                SettingsTile(image: "person.crop.circle", text: "Çıkış Yap")
                                Divider().frame(width: Const.width * 0.84)
                                SettingsTile(image: "person.crop.circle", text: "Hesabı Sil")
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    .white
                                ).cornerRadius(7)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 2, y: 4)
                        }.padding(.top , 5)
                       
                    }
                }
                .padding()
                .frame(width: Const.width)
                .background(
                    Color(UIColor(hex: "F3F3F3"))
                )
                
                
                
                
            }
        }
    }
}

#Preview {
    SettingsView()
}

struct ExtractedView: View {
    var body: some View {
        HStack{
            NavigationLink(destination: TabbarView().navigationBarBackButtonHidden(true)) {
                Image(systemName: "arrow.left.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.black)
                
            }
            
            Text("Ayarlar")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 25))
            Spacer()
            
            
            
        }.background(
            .white
        )
        .padding(.horizontal , 10)
    }
}

struct SettingsTile: View {
    var image : String
    var text : String
    var body: some View {
        HStack{
            Image(systemName: image)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
            Text(text).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Image(systemName: "chevron.forward")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
        }.padding(10)
    }
}

