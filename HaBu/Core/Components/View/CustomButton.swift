//
//  CustomButton.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void
    var width : Double?
    var textColor : Color?
       var body: some View {
           Button(action: action)
           {
               Text(title)
                   .padding()
                   .frame(width: width ?? Const.width-130  ,height: 30 )
                   .background(backgroundColor)
                   .foregroundColor(textColor ?? .white)
                   .cornerRadius(4)
        }
    }
}
#Preview {
    CustomButton(title: "login", backgroundColor: Const.primaryColor, action: {})
}
