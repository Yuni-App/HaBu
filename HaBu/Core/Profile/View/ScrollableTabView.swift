//
//  ScrollableTabView.swift
//  HaBu
//
//  Created by OmerErbalta on 27.11.2023.
//

import SwiftUI

struct ScrollableTabView: View {
    
    
    var posts : [Post]
    var saves : [Post]?
    @State var selectedFilterIndex = 0
    @State private var scrollOffset: CGFloat =  Const.width / 2
    @State private var dragDirection: DragDirection = .left
    @Binding var hideTab:Bool
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            
                HStack(alignment : .center) {
                    ScrollView{
                        ForEach(posts) { post in
                            FeedViewCell(post: post, user: User.MockData[0], hideTab: $hideTab)
                        }
                    }
                    if let saves = saves{
                        ScrollView{
                            ForEach(saves) { post in
                                FeedViewCell(post: post, user: User.MockData[0], hideTab: $hideTab)
                            }
                        }
                    }
                }
            
            
        }.content.offset(x: self.scrollOffset)
            .gesture((saves != nil) ?  DragGesture().onChanged({ value in
            dragDirection = value.translation.width > 1 ? .left : .right
        })
            .onEnded({ value in
                withAnimation(.smooth){
                if dragDirection == .right{
                    if self.selectedFilterIndex < 2 {
                        self.selectedFilterIndex += 1
                        self.scrollOffset -= Const.width * 1.025
                    }
                    else{
                        selectedFilterIndex = 0
                        self.scrollOffset = 0
                    }
                   
                }
                    else if dragDirection == .left{
                    if self.selectedFilterIndex > 0{
                        self.scrollOffset += Const.width * 1.025
                        self.selectedFilterIndex -= 1
                    }
                   
                }
            }
                print(self.selectedFilterIndex)

                
            })
                 : nil
        )
        .padding(.top,10)
    }
}

#Preview {
    ScrollableTabView(posts:Post.MockData,saves: Post.MockData, hideTab: .constant(false) )
}
