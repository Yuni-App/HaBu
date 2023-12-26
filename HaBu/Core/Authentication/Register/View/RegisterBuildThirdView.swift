//
//  RegisterBuildThirdView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildThirdView: View {
  
    @State private var isActiveDestination: Bool = false

    @Environment(\.dismiss) var dissmis
    
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
                //       TextFields.CustomTextField(text: $registerVM.textFaculty, icon: .blocked, placeHolder: "Fakülte")
                     //   TextFields.CustomTextField(text: $registerVM.textDepartment ,icon: .blocked, placeHolder: "Bölüm")
                        //       TextFields.CustomTextField(text: $registerVM.textYear ,icon: .blocked, placeHolder: "Giriş Yılı")
                     Buttons.GecilecekOlancustomButton(title: "Tamamla", buttonColor: Const.secondaryColor , textColor: .black ) {
                            registerVM.activeDestinaiton = AnyView(TabbarView())
                            Task{
                                //    isActiveDestination = await registerVM.signUp()
                            }
                            
                        }

                    }.frame(width: Const.width * 0.85, height:  Const.height * 0.35)
                        .modifier(RectangleBlurModifier(color: Const.primaryColor))
                    HStack{
                        CheckBoxView(checked: registerVM.isChecked){
                            registerVM.isChecked.toggle()
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
            .popup(isPresented: $registerVM.error, view: {
                Text(registerVM.errorMessage)
            })
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isActiveDestination, destination: {
                registerVM.activeDestinaiton
            })

        }
    }



#Preview {
    RegisterBuildThirdView()
}
