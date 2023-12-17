//
//  PopUp.swift
//  HaBu
//
//  Created by yusuf on 16.12.2023.
//

import SwiftUI

struct PopUp : View {
    @State var showingPopup = false
    var size : PopUpScreen
    var backgroundColor: Color
    var contents : String
    var btnOpen: String
    var btnClose: String
    
    var body: some View {
        ZStack {
            Button(btnOpen) {
                showingPopup = true
            }
            if showingPopup {
                ZStack {
                    backgroundColor.frame(width: size.width, height: size.height).cornerRadius(5).shadow(radius: 10).overlay {
                        VStack {
                            Spacer()
                            Text(contents)
                            Spacer()
                            Button(btnClose) {
                                showingPopup = false
                            }.frame(width: size.width, height: Const.height * 0.05).foregroundColor(.white).background(Color.black).cornerRadius(5)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PopUp(size: PopUpScreen.lage, backgroundColor: Color.brown, contents: "Nasılsın\nben iyiyim popup yapıyorum", btnOpen: "bana bas ve buton açılsın", btnClose: "Kapat soğuk yapıyor")
}


enum PopUpScreen{
    
    case xsmall
    case small
    case medium
    case lage
    case xlage
    case xxlage
    var width : CGFloat{
        switch self {
        case .xsmall:
            return Const.width * 0.6
        case .small:
            return Const.width * 0.65
        case .medium:
            return Const.width * 0.7
        case .lage:
            return Const.width * 0.8
        case .xlage:
            return Const.width * 0.9
        case .xxlage:
            return Const.width * 0.95
        }
    }
    var height : CGFloat{
        switch self {
        case .xsmall:
            return Const.height * 0.3
        case .small:
            return Const.height * 0.35
        case .medium:
            return Const.height * 0.4
        case .lage:
            return Const.height * 0.4
        case .xlage:
            return Const.height * 0.6
        case .xxlage:
            return Const.height * 0.7
        }
    }
}
