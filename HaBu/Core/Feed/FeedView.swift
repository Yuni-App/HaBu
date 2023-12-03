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
    var body: some View {
        NavigationStack{
            VStack {
                CustomTollbar(showCategoryFilter: $showCategoryFilter)
                HStack{
                    SlidableButton(destination: AnyView(AddPostView(imageList: [])), position: CGPoint(x: 0, y: 0), dragDirection: .right,text: "Post Ekle",color: Const.primaryColor,textColor:.white)
                        .padding(.top,50)
                }
                .frame(maxHeight:.ulpOfOne)
                ScrollView{
                    VStack {
                        ForEach(Post.MockData , id: \.id){post in
                            FeedViewCell(post: post,user: User.MockData[Int(post.userId)!])
                            Divider()
                        }
                    }
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
                .padding(.top,50)
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
