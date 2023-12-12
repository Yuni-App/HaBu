//
//  FeedView.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import SwiftUI

struct FeedView: View {
    @State var showCategoryFilter = false
    @EnvironmentObject var navigation : NavigationStateManager
    @State var offset:CGFloat = 0
    @State var lastOffset:CGFloat = 0
    @State var messageBox = 20
    @State var postButtonPoint:CGPoint = .init(x: 0, y: 30)
    var body: some View {
        VStack {
            ScrollView(.vertical,showsIndicators: false){
                VStack (alignment:.leading){
                    ForEach(Post.MockData , id: \.id){post in
                        FeedViewCell(data:.init(post: post,user: User.MockData[Int(post.userId)!]))
                        Divider()
                    }
                }
                .padding(.top,Const.height * 0.12)
                .overlay(
                    GeometryReader{proxy -> Color in
                        let minY = proxy.frame(in: .named("SCROLLFeed")).minY
                        let durationOffset: CGFloat = 35
                        DispatchQueue.main.async {
                            if minY < offset{
                                if offset < 0 && -minY > (lastOffset + durationOffset){
                                    withAnimation(.easeOut .speed(1.5)){
                                        print(minY)
                                        navigation.hideTabBar = true
                                    }
                                    lastOffset = -offset
                                }
                                
                            }
                            if minY > offset && -minY < (lastOffset - durationOffset){
                                withAnimation(.easeOut .speed(1.5)){
                                    navigation.hideTabBar = false
                                }
                                lastOffset = -offset
                                
                            }
                            self.offset = minY
                        }
                      return  Color.clear
                        
                    }
                    
                )
                .padding()
                .padding(.bottom,15 + navigation.bottomEdge + 35)
            }
            .coordinateSpace(name:"SCROLLFeed")
            .overlay(
                FeedViewTollBar(showCategoryFilter: $showCategoryFilter, messageBox: $messageBox, topEdge: navigation.topEdge)
                    .padding(.horizontal,20)
                    .background(.white)
                    .offset(y:navigation.hideTabBar ? (-15 - 70 - navigation.topEdge) :0)
                ,alignment: .top
            )
            .ignoresSafeArea(.all,edges: .all)
            .overlay(
                Buttons.slidableButton(page: .addPost, startPosition: CGPoint(x: 0, y: 30), position: $postButtonPoint, dragDirection: .right, text: "Post Ekle", color: Const.primaryColor, textColor: .white,navigator:_navigation)
                    .padding(.horizontal,20)
                    .offset(x:navigation.hideTabBar ? -150 : 0)
            )
            .sheet(isPresented: $showCategoryFilter) {
                CategoryFilterBottomSheet()
                    .presentationDetents([.large,.large])
            }
            
        }
    }
}


#Preview {
    InfoView()
}


struct FeedViewTollBar:View {
    @Binding var showCategoryFilter:Bool
    @Binding var messageBox : Int
    @Environment(\.colorScheme) var sheme
    var topEdge:CGFloat
    var body: some View {
        VStack{
            HStack{
                Text("HaBu!").foregroundStyle(Const.primaryColor).font(.custom("IrishGrover-Regular", size: 35))
                    .padding(10)
                Spacer()
                Button(action: {
                    showCategoryFilter = true
                    
                }, label: {
                    Image.iconManager(.filter, size: 20, weight: .bold, color: .black)     .padding(20)
                })
                
                //message icon
                //this will active at next version
                /*
                Button(action: {
                    // -> MessageBox View
                    
                }, label: {
                    Image.iconManager(.tray, size: 25, weight: .bold, color: .black)
                        .padding(.top,10)
                        .overlay(
                            Text("\(messageBox < 100 ? messageBox: 99)+")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundStyle(sheme == .dark ? .black : .white)
                                .padding(.vertical,2)
                                .padding(.horizontal,3)
                                .background(.red, in: Capsule())
                                .background(
                                    Capsule().stroke(sheme == .dark ? .black:.white,lineWidth:2)
                                )
                            
                            ,alignment: .topTrailing
                        )
                        .padding(20)
                    
                }
                )*/
                
                
            }
        }
        .padding(.top,15)
        .padding(.top,topEdge)
    }
}
