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
    var topEdge: CGFloat
    @Binding var hideTab:Bool
   @State var offset:CGFloat = 0
   @State var lastOffset:CGFloat = 0
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView(.vertical,showsIndicators: false){
                    VStack (alignment:.leading){
                        ForEach(Post.MockData , id: \.id){post in
                            FeedViewCell(post: post,user: User.MockData[Int(post.userId)!])
                            Divider()
                        }
                    }
                    .padding(.top,100)
                    .overlay(
                        GeometryReader{proxy -> Color in
                            let minY = proxy.frame(in: .named("SCROLL")).minY
                            let durationOffset: CGFloat = 35
                            DispatchQueue.main.async {
                                if minY < offset{
                                    if offset < 0 && -minY > (lastOffset + durationOffset){
                                        withAnimation(.easeOut .speed(1.5)){
                                            print(minY)
                                            hideTab = true
                                        }
                                        lastOffset = -offset
                                    }
                                    
                                }
                                if minY > offset && -minY < (lastOffset - durationOffset){
                                    withAnimation(.easeOut .speed(1.5)){
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
                .overlay(
                    FeedViewTollBar(showCategoryFilter: $showCategoryFilter, topEdge: topEdge)
                        .background(.white)
                        .offset(y:hideTab ? (-15 - 70 - topEdge) :0)
                    ,alignment: .top
                )
                .ignoresSafeArea(.all,edges: .all)
                .overlay(
                    SlidableButton(destination: AnyView(AddPostView()), position: CGPoint(x: 0, y: 30), dragDirection: .right, text: "Post Ekle", color: Const.primaryColor, textColor: .white)
                        .offset(x:hideTab ? -150 : 0)
                        
                )
            

                
               
                .sheet(isPresented: $showCategoryFilter) {
                    CategoryFilterBottomSheet()
                        .presentationDetents([.large,.large])
                }
                
            }
        }
        
      
       
    }
}


#Preview {
    TabbarView()
}


struct FeedViewTollBar:View {
    @Binding var showCategoryFilter:Bool
     var topEdge:CGFloat
    var body: some View {
        VStack{
            CustomTollbar(showCategoryFilter: $showCategoryFilter)
        }
        .padding(.top,15)
        .padding(.top,topEdge)
    }
}
