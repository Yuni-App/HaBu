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
    CustomButton(title: "Giriş", backgroundColor: Const.primaryColor, action: {5>3}, destination: AnyView(FeedView()), size: CustomButtonSize.medium)
}


enum CustomButtonSize{
    case xxxsmall
    case xxsmall
    case xsmall
    case small
    case medium
    case lage
    case xlage
    case xxlage
    var width : CGFloat{
        switch self {
        case .xxxsmall:
            return Const.width * 0.3
        case .xxsmall:
            return Const.width * 0.4
        case .xsmall:
            return Const.width * 0.5
        case .small:
            return Const.width * 0.6
        case .medium:
            return Const.width * 0.7
        case .lage:
            return Const.width * 0.8
        case .xlage:
            return Const.width * 0.9
        case .xxlage:
            return Const.width * 0.95
         }
    }
    var height : CGFloat{
        switch self {
        case .xxxsmall:
            return Const.height * 0.04
        case .xxsmall:
            return Const.height * 0.04
        case .xsmall:
            return Const.height * 0.04
        case .small:
            return Const.height * 0.04
        case .medium:
            return Const.height * 0.05
        case .lage:
            return Const.height * 0.06
        case .xlage:
            return Const.height * 0.06
        case .xxlage:
            return Const.height * 0.07
        }
    }
}
