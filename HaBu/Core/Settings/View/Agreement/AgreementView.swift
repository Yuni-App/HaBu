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
          CustomSettingsTollBar(title: "Gizlilik Sözleşmesi",destinaiton: AnyView(SettingsView()))
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
