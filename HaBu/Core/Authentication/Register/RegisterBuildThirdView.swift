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
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.registerVector)
                    VStack{
                        TextFields.CustomTextField(icon: .blocked, placeHolder: "Fakülte")
                        TextFields.CustomTextField(icon: .blocked, placeHolder: "Bölüm")
                        TextFields.CustomTextField(icon: .blocked, placeHolder: "Giriş Yılı")
                        CustomButton(title: "Tamamla", backgroundColor: Const.primaryColor, action: {true
                        }, destination: AnyView(TabbarView().navigationBarBackButtonHidden(true)), size: CustomButtonSize.small)
                        
                    }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                    HStack{
                        CheckBoxView(checked: isChecked){
                        }
                        Text("Lütfen").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{  Text("Gizlilik Politikasın").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 14))}
                        }
                        Text("Onaylayınız").foregroundStyle(.black).font(.system(size: 14))
                    }}.frame(width: Const.width , height: Const.height+100)
            }.background(Const.authBackGroundColor)
        }
    }
}

#Preview {
    RegisterBuildThirdView()
}
