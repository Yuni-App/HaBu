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
        VStack {
            HStack(alignment: .center) {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    
                    TextField("", text: $text)
                        .foregroundColor(.white)
                    
                }
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(Color(UIColor(hex: "13446C")))
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Const.secondaryColor, lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)


        
        }
}

#Preview {
    CustomTextField(icon: "mail", placeHolder: "place holder")
}


/*
 VStack {
            TextField("Ne düşünüyorsunuz?", text: $text)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(height: UIScreen.main.bounds.height / 3)
        }
        .padding()
 
 
 */

/*
 TextField("Email", text: $text)
     .frame(height: 235)
     .textFieldStyle(PlainTextFieldStyle())
     .padding([.horizontal], 4)
     .background(Color.gray.opacity(0.2))
     .cornerRadius(4)
     .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
     .lineLimit(5)
 */
