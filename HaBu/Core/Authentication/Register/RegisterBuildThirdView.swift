//
//  RegisterBuildThirdView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildThirdView: View {
    @State private var isChecked: Bool = false
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    CustomImageRectangle(width: Const.width, height: Const.height/3, imagePath: ImageManager.registerThirdVector)
                    ZStack{
                        Image("")
                            .frame(width: 370, height: 330)
                            .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y:4)
                        VStack{
                            CustomTextField(icon: "person.fill", placeHolder: "Fakülte")
                            CustomTextField(icon: "person.fill", placeHolder: "Bölüm")
                            CustomTextField(icon: "calendar", placeHolder: "Giriş Yılı")
                            CustomLinkButton(title: "Tamamla", backgroundColor: Const.primaryColor, action: {

                            }, destinaiton: AnyView(TabbarView()), size: CustomButtonSize.small).padding(.top , 50)
                        }
                    }
                    HStack{
                        CheckBoxView(checked: isChecked){
                            
                        }
                        Text("Lütfen").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{  Text("Gizlilik Politikasını ").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 14))}
                        }
                        Text("Onaylayınız").foregroundStyle(.black).font(.system(size: 14))
                }.padding(.top , 30)}.padding(.horizontal , 20)
                    .frame(width: 430, height: 932)
                    .background(
                        BackgroundLinearColor()
                )
            }
        }
    }
}

#Preview {
    RegisterBuildThirdView()
}
