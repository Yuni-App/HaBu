//
//  LogOutView.swift
//  HaBu
//
//  Created by mert alp on 24.12.2023.
//

import SwiftUI

struct LogOutView: View {
    @StateObject var VM : LogOutViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isActiveDestination: Bool = false

    init(){
        self._VM = StateObject(wrappedValue: LogOutViewModel(authService: AuthService()))
    }
    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Çıkış Yap ")
            ScrollView{
                VStack{
                    HStack{
                        Text("Tekrar Giriş İçin Şifre Gerekir. ").fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("Çıkış Yapmak İstediğinize Emin misiniz ? ").fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack{
                        Buttons.customButton(title: "Çıkış",buttonColor: Const.primaryButtonColor, size: .xxxsmall) {
                            Task {
                                isActiveDestination  = await VM.logout()
                            }
                        }
                        Spacer()
                    }
                    
                }   .padding()
                    .frame(width: Const.width)
              
            }.navigationBarBackButtonHidden(true)
                .background(
                    Const.primaryBackGroundColor
                )
        }.navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isActiveDestination, destination:{
                InfoView()
            })
       

    }
}

#Preview {
    LogOutView()
}
