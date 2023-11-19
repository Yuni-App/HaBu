//
//  AddImageBottomSheet.swift
//  HaBu
//
//  Created by mert alp on 19.11.2023.
//

import SwiftUI

struct AddImageBottomSheet: View {
    var body: some View {
        VStack(alignment : .leading){
            HStack{
                Button(action: {
                    // kamerayı aç
                    
                }, label: {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Text("Kamerayi Aç")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            )
            }
            Button(action: {
                // galeriyi aç
                
            }, label: {
                //update icon
                Image(systemName: "camera")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                Text("Galeriyi Aç")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                
            })
        }
        .presentationDetents([.medium,.height(CGFloat(Const.height/6))])
    }

}

#Preview {
    AddImageBottomSheet()
}
