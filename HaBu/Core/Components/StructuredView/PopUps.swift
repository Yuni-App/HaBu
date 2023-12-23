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
                Buttons.customButton(title:  "Anonim Gönderi", backgroundColor: Const.primaryButtonColor, action: {
                    withAnimation {
                        selectedOption.wrappedValue = .anonymous
                        isPopupVisible.wrappedValue.toggle()
                    }
                    return false
                }, size: CustomButtonSize.xxsmall , textColor: .white)
                Buttons.customButton(title:  "Açık Gönderi", backgroundColor: Const.primaryButtonColor.opacity(0.7), action: {
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
    
    //popup2 only has close button
    struct PopUp2: View {
        var title :String
        var contents: String
        var size : PopUpScreen
        @State var isPopUpPresented: Binding<Bool>
        var body: some View {
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
    //popUp3 only has close multiply button
    struct Xbutton: View {
        var size : PopUpScreen
        var contents : String
        @State var isPopUpPresented: Binding<Bool>
        var body: some View {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        isPopUpPresented.wrappedValue = false
                    }, label: {
                        Image("close").resizable().frame(width: Const.width * 0.1, height: Const.height * 0.05)
                    })
                }.padding(7)
                Text(contents).padding().fontWeight(.semibold)
                Spacer()
            }.frame(width: size.width, height: size.height)
        }
    }
    //POPUP4 SAME USERNAME
    struct LoginPopup: View {
        var size: PopUpScreen
        var contents : String
        @State var okeybtn: Binding<Bool>
        var body: some View {
            VStack{
                Image("warning").resizable().frame(width: Const.width * 0.2,height: Const.height * 0.1)
                Spacer()
                Text(contents).fontWeight(.semibold).padding(7)
                Spacer()
                CustomButton(title: "Tamam", backgroundColor: .brown, action: {
                    okeybtn.wrappedValue = false
                    return true
                }, size: .lage)
            }.frame(width: size.width, height: size.height).padding(7)
        }
    }
}
