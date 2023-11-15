//
//  FeedView.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                
                
            }.toolbar{
                
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
                        //Filter Button Action
                        
                    }, label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .foregroundStyle(.black)
                    })
                    
                }
                
            }
        }
    }
}

#Preview {
    FeedView()
}