//
//  ConfidentialityAgreementView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct AgreementView: View {
    var body: some View {
        VStack{
            AgreementAppBar()
            ScrollView{
                Text(Const.agreement).padding(25)
            }.frame(width: Const.width)
                .background(
                    Const.primaryBackGroundColor
                )
        }
    }
}

#Preview {
    AgreementView()
}
@ViewBuilder
func AgreementAppBar()->some View {
    ZStack{
        HStack{
            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
                Image.iconManager(AppIcon.back, size: 35, weight: .bold, color: .black)
            }
            Spacer()
        }
        Text("Gizlilik Sözleşmesi")
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.system(size: 25))
            .frame(maxWidth: .infinity, alignment: .center)
        Spacer()
    }.background(
        .white
    )
    .padding(.horizontal , 10)
}
