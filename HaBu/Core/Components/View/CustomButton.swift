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
    var action: () -> Bool
    var destination : AnyView?
    var size : CustomButtonSize
    var textColor : Color?
    @State private var isActiveDestination: Bool = false
    
    var body: some View {
        
        NavigationLink(
            destination: destination ?? AnyView(EmptyView()),
            isActive: $isActiveDestination,
            label: {})
        
        Button(action: {
            if action(){
                isActiveDestination = true
            }
        }, label: {
            Text(title)
                .padding()
                .frame(width: size.width , height: size.height)
                .background(backgroundColor)
                .foregroundColor(textColor ?? .white)
                .cornerRadius(4)
        })
    }
}

#Preview {
    CustomButton(title: "Giriş", backgroundColor: Const.primaryColor, action: {4>3}, destination: AnyView(FeedView()), size: CustomButtonSize.medium)
}

