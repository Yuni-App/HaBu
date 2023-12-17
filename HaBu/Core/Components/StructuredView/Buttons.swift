//
//  Buttons.swift
//  HaBu
//
//  Created by OmerErbalta on 1.12.2023.
//

import Foundation
import SwiftUI

class Buttons{
    struct customButton: View {
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
    
    //customButton1
    @ViewBuilder
    static func customButton1(title:String , backgroundColor:Color,action:@escaping(()->Void),size:CustomButtonSize,textColor:Color?,destination:AnyView?) -> some View{
        NavigationLink {
            destination
        } label: {
            Text(title)
                .padding()
                .frame(width: size.width , height: size.height)
                .background(backgroundColor)
                .foregroundColor(textColor ?? .white)
                .cornerRadius(4)
        }
        
    }
    
    
    //actionButton
    @ViewBuilder
    static func actionButton(buttonType: ActionButtons, action: @escaping () -> Void, getNumber: Int? = nil ,textAction: @escaping () -> Void = {} ) -> some View {
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
                .onTapGesture {
                    textAction()
                }
           
            
        }
    }
    
    @ViewBuilder
    static func backButton( action: @escaping ()-> Void,color:Color = .black) -> some View{
        Button(action: {
            action()
        }, label: {
            Image.iconManager(.back, size: 25, weight: .bold, color: color)
        })
        
    }
    
    
    struct SlidableButton: View {
        @State private var shouldNavigate = false
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
        }
        
        
        var body: some View {
            HStack{
                if dragDirection == .left {
                    Image(systemName:"chevron.left")
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
                Text(text)
                    .font(.title3)
                    .fontWeight(.semibold)
                if dragDirection == .right{
                    Image(systemName:"chevron.right")
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
            }
            .padding(.vertical,5)
            .padding(.horizontal,10)
            .padding(dragDirection.padding,110)
            .background(color)
            .foregroundStyle(textColor)
            .background(
                NavigationLink(destination:AnyView(destinaiton), isActive: $shouldNavigate) {
                    EmptyView()
                }
                    .hidden()
            )
            .clipShape(
                .rect(
                    topLeadingRadius: dragDirection == .left ? 20 : 0,
                    bottomLeadingRadius:  dragDirection == .left ? 20 : 0,
                    bottomTrailingRadius:  dragDirection == .left ? 0 : 20,
                    topTrailingRadius:  dragDirection == .left ? 0 : 20
                )
            )
            .position(position)
            .gesture(DragGesture().onChanged({ value in
                if value.translation.width > 0 && value.translation.width < 50 && dragDirection == .right{
                    print(value.translation)
                    position = CGPoint(x: startPosition.x + value.translation.width, y :startPosition.y)
                }
                else if value.translation.width < 0 && value.translation.width > -50 && dragDirection == .left{
                    print(value.translation)
                    position = CGPoint(x: startPosition.x + value.translation.width, y :startPosition.y)
                }
            })
                .onEnded({ _ in
                    position = CGPoint(x:startPosition.x, y :startPosition.y)
                    shouldNavigate = true
                    
                })
            )
        }
    }


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

