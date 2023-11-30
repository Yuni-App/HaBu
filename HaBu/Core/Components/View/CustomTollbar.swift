//
//  CustomTollbar.swift
//  HaBu
//
//  Created by OmerErbalta on 30.11.2023.
//

import SwiftUI

struct CustomTollbar: View {
    @Binding var showCategoryFilter : Bool
    var body: some View {
        HStack{
            Text("HaBu!").foregroundStyle(Const.primaryColor).font(.custom("IrishGrover-Regular", size: 35))
                .padding(10)
            Spacer()
            
            Button(action: {
                showCategoryFilter = true
                
            }, label: {
                Image.iconManager(.filter, size: 20, weight: .bold, color: .black)
            })
            
            Button(action: {
                // -> MessageBox View
                
            }, label: {
                ZStack{
                    Image.iconManager(.tray, size: 25, weight: .bold, color: .black)
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
                .padding(10)
                
            }
        )
          
            
        }
    }
}

#Preview {
    CustomTollbar(showCategoryFilter: .constant(false))
}

/* .toolbar{
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
 
}*/
