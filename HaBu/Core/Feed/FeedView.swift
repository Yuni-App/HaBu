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
                HStack{
                    SlidableButton(destination: AnyView(AddPostView().navigationBarBackButtonHidden(true)), position: CGPoint(x: 0, y: 0), dragDirection: .right,text: "Post Ekle",color: Const.primaryColor,textColor:.white)
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
                .toolbar{
                    ToolbarItem(placement:.topBarLeading){
                        NavigationLink {
                        // CreatePost()
                        } label: {
                            Text("HaBu!").foregroundStyle(Const.primaryColor).font(.custom("IrishGrover-Regular", size: 35))
                        }
                    } // App Icon
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            // -> MessageBox View
                            
                        }, label: {
                            ZStack{
                                Image.iconManager(.tray, size: 20, weight: .bold, color: .black)
                                Image.iconManager(.circleFill, size:15 , weight: .bold, color: .red)
                                    .padding(.leading,25)
                                    .padding(.bottom,25)
                                Text("5")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.leading,25)
                                    .padding(.bottom,25)
                                    .foregroundStyle(.white)
                                
                                
                            }
                            
                        })
                    } // MessageBox
                    ToolbarItem(){
                        Button(action: {
                            showCategoryFilter = true
                            
                        }, label: {
                            Image.iconManager(.filter, size: 20, weight: .bold, color: .black)
                        })
                        
                    } //filter
                    
            }
            }
        }
    }
}


#Preview {
    FeedView()
}
