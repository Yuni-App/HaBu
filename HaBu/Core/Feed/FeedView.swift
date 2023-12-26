//
//  FeedView.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import SwiftUI

struct FeedView: View {
    @State var showCategoryFilter = false
    var bottomEdge:CGFloat
    @Binding var hideTab:Bool
    @State var offset:CGFloat = 0
    @State var lastOffset:CGFloat = 0
    @State var messageBox = 20
    @State var addPostButtonPosition = CGPoint(x: 10, y: 20)
    @State var navigate = false
    @State var navigationPage : AnyView? = nil
    var topEdge: CGFloat
    var body: some View {
       
            VStack {
                ScrollView(.vertical,showsIndicators: false){
                    VStack (alignment:.leading){
                        ForEach(Post.MockData , id: \.id){post in
                            FeedViewCell(post: post,user: User.MockData[Int(post.userId)!]
                            )
                            Divider()
                        }
                    }
                    .padding(.top,Const.height * 0.12)
                    .overlay(
                        GeometryReader{proxy -> Color in
                            let minY = proxy.frame(in: .named("SCROLL")).minY
                            let durationOffset: CGFloat = 35
                            DispatchQueue.main.async {
                                print(minY)
                                if minY < offset{
                            
                                    if offset < 0 && -minY > (lastOffset + durationOffset){
                                        withAnimation(.easeOut ){
                                            print(offset)
                                            hideTab = true
                                        }
                                        lastOffset = -offset
                                    }
                                    
                                }
                                if minY > offset && -minY < (lastOffset - durationOffset){
                                    withAnimation(.easeOut){
                                        hideTab = false
                                    }
                                    lastOffset = -offset
                                    
                                }
                                self.offset = minY
                            }
                            return Color.clear
                            
                        }
                        
                    )
                    .padding()
                    .padding(.bottom,15 + bottomEdge + 35)
                }
                .coordinateSpace(name:"SCROLL")
                //TollBar
                .overlay(
                    FeedViewTollBar(showCategoryFilter: $showCategoryFilter, messageBox: $messageBox, topEdge: topEdge)
                        .background(.white)
                        .offset(y:hideTab ? (-15 - 70 - topEdge) :0)
                    ,alignment: .top
                )
                .ignoresSafeArea(.all,edges: .all)
                //Slidable Button
                .overlay(
                    Buttons.SlidableButton(action: {
                        navigate = true
                        navigationPage = AnyView(AddPostView())
                    }, position: CGPoint(x: 20, y: 40), dragDirection: .right, text: "Post Ekle", color: Const.primaryColor, textColor: .white)
                    .offset(x:hideTab ? -Const.width * 0.5:0)
                    
                )
              
                
                
                
                
                .sheet(isPresented: $showCategoryFilter) {
                    CategoryFilterBottomSheet()
                        .presentationDetents([.height(Const.height * 0.6)])
                }
               
                
            }
        
        .navigationDestination(isPresented: $navigate) {
            navigationPage
        }
     
        
    }
}


#Preview {
    TabbarView()
}


struct FeedViewTollBar:View {
    @Binding var showCategoryFilter:Bool
    @Binding var messageBox : Int
    
    @Environment(\.colorScheme) var sheme
    var topEdge:CGFloat
    var body: some View {
        VStack{
            HStack{
                Text("Yuni").foregroundStyle(Const.primaryColor).font(.custom("Kodchasan-Bold", size: 40))
                    .padding(10)
                Spacer()
                
                Button(action: {
                    showCategoryFilter = true
                    
                }, label: {
                    Image.iconManager(.filter, size: 20, weight: .bold, color: .black).padding(20)
                })
                //message icon
                //this will active at next version
                
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
                       
                )
                
                
                
            }
            
        }
        
        .padding(.horizontal,15)
        .padding(.top,topEdge + 15)
        .overlay(
            Rectangle()
                .stroke().opacity(0.3)
                .background(Color.clear)
        )
    }
}
