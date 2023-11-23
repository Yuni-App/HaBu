//
//  CustomTextField2.swift
//  HaBu
//
//  Created by OmerErbalta on 23.11.2023.
//

import SwiftUI

struct CustomTextField2: View {
    let headline : String
    let color: Color
    let islocked : Bool
    var icon: AppIcon?
    var iconColor:Color?
    @Binding var text: String
    var placeHolder : String
    var contentType : UITextContentType
    var keybordType : UIKeyboardType
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(headline)
                        .foregroundColor(color)
                        .fontWeight(.bold)
                        .font(.headline)
                    if let icon = icon{
                        Image.iconManager(icon, size: 16, weight: .semibold, color: iconColor ?? .white)
                    }
                    Spacer()
                }
                HStack {
                    if islocked == true{
                        Image.iconManager(.lock, size: 16, weight: .semibold, color: iconColor ?? .white)
                    }
                    TextField(placeHolder, text: $text)
                        .textContentType(contentType)
                        .keyboardType(keybordType)
                    .disabled(islocked)
                }
                Divider().frame(width: 330).background(Color.black)
            }
            .frame(width: Const.width * 0.85)
            .padding()
        }
    }
}

#Preview {
    CustomTextField2(headline: "İsim", color: .blue, islocked: true, icon: .lock, iconColor: .blue, text: .constant(""), placeHolder:"isminizi giriniz",contentType: .name,keybordType: .namePhonePad)
}
