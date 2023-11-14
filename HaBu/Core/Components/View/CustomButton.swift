//
//  CostomButton.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct CustomButton: View {
    var title: String
       var backgroundColor: Color
       var action: () -> Void
    var destinaiton : AnyView

       var body: some View {
           Button(
               action: action) {
                   NavigationLink(destination: destinaiton) {
                       Text(title)
                           .padding()
                           .frame(width: UIScreen.main.bounds.width * 3/4  )
                           .background(backgroundColor)
                           .foregroundColor(.white)
                           .cornerRadius(7)
                   }
                   
               }
    }
}

#Preview {
    CustomButton(title: "", backgroundColor: .black, action: {}, destinaiton: AnyView(LoginView()))
}
