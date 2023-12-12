//
//  RegisterBuildThirdView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildThirdView: View {
    @State private var isChecked: Bool = false
    @Environment(\.dismiss) var dissmis

    var body: some View {
            ZStack {
                VStack{
                    Buttons.backButton {
                        dissmis()
                    }
                    .padding(.trailing,Const.width * 0.9)
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.registerVector)
                    VStack{
                        TextFields.CustomTextField(icon: .blocked, placeHolder: "Fakülte")
                        TextFields.CustomTextField(icon: .blocked, placeHolder: "Bölüm")
                        TextFields.CustomTextField(icon: .blocked, placeHolder: "Giriş Yılı")
                        Buttons.customButton1(title:"Tamamla", backgroundColor: Const.primaryColor, action: {
                        }, size: .small, textColor: .white, destination: AnyView(TabbarView()))
                    }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .background(
                            RectangleBlur(color: Const.primaryColor))
                    HStack{
                        CheckBoxView(checked: isChecked){
                        }
                        Text("Lütfen").foregroundStyle(.black).font(.system(size: 14))
                        Button(action: {
                            //open  bottomsheet 
                        }, label: {
                            Text("Gizlilik Politikası").foregroundStyle(.blue).fontWeight(.bold)
                        })
                        Text("Onaylayınız").foregroundStyle(.black).font(.system(size: 14))
                    }}.frame(width: Const.width , height: Const.height+100)
            }.background(Const.authBackGroundColor)
            .navigationBarBackButtonHidden(true)

        }
    }



#Preview {
    RegisterBuildThirdView()
}
