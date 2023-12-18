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
        VStack {
            Button(btnOpen) {
                showingPopup = true
            }.overlay {
                    if showingPopup {
                        ZStack {
                            backgroundColor.frame(width: size.width, height: size.height).cornerRadius(5).shadow(radius: 10)
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
    PopUp(size: PopUpScreen.xxlage, backgroundColor: Color.brown, contents: "Nasılsın\nben iyiyim popup yapıyorum", btnOpen: "bana bas ve buton açılsın", btnClose: "Kapat soğuk yapıyor")
}
