//
//  CostomButton.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

//update
enum CustomButtonWidth{
    case xxxsmall
    case xxsmall
    case xsmall
    case small
    case medium
    case lage
    case xlage
    case xxlage
    var deminsion : CGFloat{
        switch self {
        case .xxxsmall:
            return 20
        case .xxsmall:
            return 30
        case .xsmall:
            return 40
        case .small:
            return 50
        case .medium:
            return 60
        case .lage:
            return 70
        case .xlage:
            return 80
        case .xxlage:
            return 90
        }
    }
}
enum CustomButtonHeight{
    case xxxsmall
    case xxsmall
    case xsmall
    case small
    case medium
    case lage
    case xlage
    case xxlage
    var deminsion : CGFloat{
        switch self {
        case .xxxsmall:
            return 20
        case .xxsmall:
            return 30
        case .xsmall:
            return 40
        case .small:
            return 50
        case .medium:
            return 60
        case .lage:
            return 70
        case .xlage:
            return 80
        case .xxlage:
            return 90
        }
    }
}

struct CustomLinkButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void
    var destinaiton : AnyView?
    var width : Double?
    var size : CustomButtonWidth?
    var textColor : Color?

       var body: some View {
           Button(
               action: action) {
                   NavigationLink(destination: destinaiton) {
                       Text(title)
                           .padding()
                           .frame(width: size?.deminsion,height: 30 )
                           .background(backgroundColor)
                           .foregroundColor(textColor ?? .white)
                           .cornerRadius(4)
                   }
               }
    }
}

#Preview {
    CustomLinkButton(title: "login", backgroundColor: Const.primaryColor, action: {}, destinaiton: AnyView(LoginView()) , size: CustomButtonWidth.medium)
}
