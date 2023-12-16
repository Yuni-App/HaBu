//
//  ConfidentialityAgreementView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct AgreementView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            CustomSettingsTollBar(action: {
                dismiss()
            }, title: "Gizlilik Sözleşmesi")
       
            ScrollView{
                Text(Const.agreement).padding(25)
            }.frame(width: Const.width)
                .background(
                    Const.primaryBackGroundColor
                )
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AgreementView()
}
