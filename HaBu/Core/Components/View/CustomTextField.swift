//
//  CustomTextField.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct CustomTextField: View {
    @State private var text: String = ""
    var icon : String
    var placeHolder : String
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width:20,height: 20)
            TextField(placeHolder, text: $text)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}

#Preview {
    CustomTextField(icon: "", placeHolder: "")
}
