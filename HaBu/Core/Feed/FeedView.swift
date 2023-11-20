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
            ScrollView{
                ForEach(Post.MockData , id: \.id){post in
                    FeedViewCell(post: post,user: User.MockData[Int(post.userId)!])
                    Divider()

                }
            }
            .sheet(isPresented: $showCategoryFilter) {
                CategoryFilter()
                    .presentationDetents([.large,.height(Const.height * 0.3)])
            }
            .toolbar{
                
                ToolbarItem(placement:.topBarLeading){
                    Text("HaBu!").foregroundStyle(Const.primaryColor).font(.custom("IrishGrover-Regular", size: 35))
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        // -> MessageBox View
                        
                    }, label: {
                        ZStack{
                            Image(systemName: "tray.fill")
                                .font(.title2)
                                .foregroundStyle(.black)
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.red)
                                .font(.subheadline)
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
                }
                ToolbarItem(){
                    Button(action: {
                        showCategoryFilter = true
                        
                    }, label: {
                        Image("filter")
                            .resizable()
                            .frame(width: 30,height: 30)
                    })
                    
                }
                
            }
        }
    }
}


#Preview {
    FeedView()
}
