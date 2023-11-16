//
//  RegisterBuildThirdView.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct RegisterBuildThirdView: View {
    @State private var isChecked: Bool = false

    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    CustomImageRectangle(width: 227, height: 376, imagePath: ImageManager.infoVector)
                    CustomTextField(icon: "person.fill", placeHolder: "Fakülte")
                    CustomTextField(icon: "person.fill", placeHolder: "Bölüm")
                    CustomTextField(icon: "calendar", placeHolder: "Giriş Yılı")
                    HStack{
                        Spacer()
                        CustomButton(title: "Tamamla", backgroundColor: Const.primaryColor, action: {
                        }, destinaiton: AnyView(FeedView()), width: Const.width/3)
                    }
                    Spacer()
                    HStack{
                        CheckBoxView(checked: $isChecked)

                        Text("Lütfen").foregroundStyle(.black).font(.system(size: 14))
                        NavigationLink {
                            LoginView()
                        } label: {
                            HStack{  Text("Gizlilik Politikasını ").foregroundStyle(.blue).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 14))}
                        }
                        Text("Onaylayınız").foregroundStyle(.black).font(.system(size: 14))

                }}.padding(30)
                    .frame(width: 430, height: 932)
                    .background(
                        BackgroundLinearColor()
                    )
            }
        }
    }
}

#Preview {
    RegisterBuildThirdView()
}
