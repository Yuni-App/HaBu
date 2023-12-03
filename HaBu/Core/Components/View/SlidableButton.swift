//
//  SlidableButton.swift
//  HaBu
//
//  Created by OmerErbalta on 23.11.2023.
//
/*  SlidableButton(destination: AnyView(EditProfileView(user: User.MockData[0])), position:editButtonPosition, dragDirection: .left, text: "Edit", color: .white, textColor: .black)*/


import SwiftUI
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

#Preview {
    SlidableButton(destination: AnyView(TabbarView()), position: CGPoint(x:Const.width / 3 , y:Const.height / 3 ), dragDirection: .left, text: "Deneme", color: Const.primaryColor, textColor: .white)
}

