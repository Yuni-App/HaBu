//
//  FeedView.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import SwiftUI

struct FeedView: View {
    @State var showCategoryFilter = false
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
                    ForEach(Post.MockData , id: \.id){post in
                        FeedViewCell(post: post,user: User.MockData[Int(post.userId)!])
                        Divider()

                    }
                }
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
    FeedView()
}
