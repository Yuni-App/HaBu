//
//  Buttons.swift
//  HaBu
//
//  Created by OmerErbalta on 1.12.2023.
//

import Foundation
import SwiftUI

class Buttons{
    
    //customButton1
    @ViewBuilder
   static func customButton1(title:String , backgroundColor:Color,action:@escaping(()->Bool) ,destination:AnyView?,size:CustomButtonSize,textColor:Color?) -> some View{
        @State var isActiveDestination: Bool = false
        NavigationLink(
            destination: destination ?? AnyView(EmptyView()),
            isActive: $isActiveDestination,
            label: {})
        
        Button(action:{
            isActiveDestination = action()
           
        }, label: {
            Text(title)
                .padding()
                .frame(width: size.width , height: size.height)
                .background(backgroundColor)
                .foregroundColor(textColor ?? .white)
                .cornerRadius(4)
        })
    }
   
    
    //actionButton
    @ViewBuilder
    static func actionButton(buttonType: ActionButtons, action: @escaping () -> Void, getNumber: Int? = nil) -> some View {
        let number = getNumber != nil ? String(getNumber!) : " "
        VStack {
            Button(action: {
                action()
            }, label: {
                Image(uiImage: buttonType.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            })
            Text("\(number) \(buttonType.text)")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .font(.caption2)
        }
    }

    //slidableButton
    /*@State private var shouldNavigate = false
     var destinaiton : AnyView
     @State var position : CGPoint
     let dragDirection : DragDirection
     let startPosition:CGPoint
     let text : String
     let color:Color
     let textColor:Color
     init(destination :AnyView, position: CGPoint,dragDirection:DragDirection,text: String,color:Color,textColor:Color) {
         self.destinaiton = destination
         self.position = position
         self.startPosition = position
         self.dragDirection = dragDirection
         self.text = text
         self.color = color
         self.textColor = textColor
     }*/
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
enum ActionButtons {
    case unLike
    case liked
    case bubble
    case send
    case savePost
    case savedPost
    var icon : UIImage{
        switch self {
        case .unLike:
            return UIImage(systemName: "heart")!
        case .liked:
            return UIImage(systemName: "heart.fill")!.tinted(with: Const.primaryUiColor)!
        case .bubble:
           return UIImage(systemName: "bubble.right")!
        case .send:
           return UIImage(systemName: "paperplane")!
        case .savePost:
            return UIImage(systemName: "bookmark")!
        case .savedPost:
            return UIImage(systemName: "bookmark.fill")!
        }
    }
    
    var text : String{
        switch self{
        case .unLike:
            return "like"
        case .liked:
            return "like"
        case .bubble:
            return "yorum"
        case .send:
            return "send"
        case .savePost:
            return "kaydet"
        case .savedPost:
            return "kaydet"
        }
    }
}
enum DragDirection {
    case none
    case right
    case left
    
    var padding:Edge.Set{
        switch self {
        case .none:
            return .trailing
        case .right:
            return .leading
        case .left:
            return .trailing
        }
    }
}
