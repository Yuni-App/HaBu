//
//  CustomTextField3.swift
//  HaBu
//
//  Created by mert alp on 3.12.2023.
//

import SwiftUI
struct CustomTextField3: View {
    @State private var text: String = ""
    var icon : AppIcon
    var placeHolder : String
    var body: some View {
        VStack {
            VStack {
                TextField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .overlay(
                      HStack {
                          if text.isEmpty {
                              Image.iconManager(icon, size: 20, weight: .bold, color: .gray)
                                  .padding(.leading, 8)
                              Text(placeHolder)
                              Spacer()
                          }
                      }
                    )
            }
        }
  


        
        }
}

#Preview {
    CustomTextField3(icon: AppIcon.back, placeHolder: "place holder")
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
