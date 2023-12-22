//
//  PopUps.swift
//  HaBu
//
//  Created by yusuf on 17.12.2023.
//

import SwiftUI

class PopUps{
    @ViewBuilder
    static func AddPostPopup(selectedOption : Binding<ImageType> , isPopupVisible : Binding<Bool>, title: String, contents: String, size: PopUpScreen,backgroundColor: Color)->some View {
        VStack {
            Text(title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.black).padding(.bottom,5)
            Spacer()
            Text(contents).foregroundColor(Const.secondaryButtonColor)
            Spacer()
            HStack{
                CustomButton(title:  "Anonim Gönderi", backgroundColor: Const.primaryButtonColor, action: {
                    withAnimation {
                        selectedOption.wrappedValue = .anonymous
                        isPopupVisible.wrappedValue.toggle()
                    }
                    return false
                }, size: CustomButtonSize.xxsmall , textColor: .white)
                CustomButton(title:  "Açık Gönderi", backgroundColor: Const.primaryButtonColor.opacity(0.7), action: {
                    withAnimation {
                        selectedOption.wrappedValue = .notAnonymous
                        isPopupVisible.wrappedValue.toggle()
                    }
                    return false
                }, size: CustomButtonSize.xxsmall , textColor: .white)
            }
        }.padding(.vertical,10)
        .padding(.horizontal,5)
        .frame(width: size.width ,height: size.height )
        .background(backgroundColor)
        .cornerRadius(5)
    }
    @ViewBuilder
    static func PopUp2(title: String, contents: String, size: PopUpScreen, isPopUpPresented: Binding<Bool>) -> some View {
        VStack {
            Text(title).fontWeight(.semibold).foregroundStyle(Color.black).padding(.bottom, 5).font(.title3)
            Spacer()
            Text(contents).foregroundStyle(Color.secondary).font(.body)
            Spacer()
            CustomButton(title: "Kapat", backgroundColor: .blue, action: {
                isPopUpPresented.wrappedValue = false
                return true// Fix the binding variable here
            }, size: .xlage)
        }.frame(width: size.width, height: size.height)
    }

}
