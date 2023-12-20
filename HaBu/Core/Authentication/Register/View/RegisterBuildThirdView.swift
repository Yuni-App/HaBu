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
    @State private var textFaculty: String = ""
    @State private var textDepartment : String = ""
    @State private var textYear : String  = ""
    
    @StateObject var registerVM : RegisterViewModel
    init(){
        self._registerVM = StateObject(wrappedValue: RegisterViewModel(authService: AuthService()))
    }

    var body: some View {
            ZStack {
                VStack{
                    Buttons.backButton {
                        dissmis()
                    }
                    .padding(.trailing,Const.width * 0.9)
                    CustomImage(width: Const.width, height: Const.height * 0.4, imagePath: ImageManager.registerVector)
                    VStack{
                        TextFields.CustomTextField(text: $textFaculty, icon: .blocked, placeHolder: "Fakülte")
                        TextFields.CustomTextField(text: $textDepartment ,icon: .blocked, placeHolder: "Bölüm")
                        TextFields.CustomTextField(text: $textYear ,icon: .blocked, placeHolder: "Giriş Yılı")
                        Buttons.customButton1(title:"Tamamla", backgroundColor: Const.primaryColor, action: {
                        }, size: .small, textColor: .white, destination: AnyView(TabbarView()))
                    }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .modifier(RectangleBlurModifier(color: Const.primaryColor))
                    HStack{
                        CheckBoxView(checked: isChecked){
                        }
                        Text("Lütfen").foregroundStyle(.black).font(.system(size: 14))
                        Button(action: {
                            registerVM.signUp()
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
