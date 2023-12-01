//
//  CommentBottomSheet.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct CommentBottomSheet: View {
    @State private var commentText = ""
    var body: some View {
        ScrollView {
            ForEach(0..<4){_ in
                CommentViewCell(user: User.MockData[0])
            }
        }
        .padding(.vertical,20)
        HStack{
            TextField("Yorum...", text: $commentText)
                .modifier(IGTextFieldModifier())
            Button(action: {
            }, label: {
                Image.iconManager(.paperplane, size: 30, weight: .bold, color: Const.thirColor)
                    .padding(10)
            })
        }
    }
}

#Preview {
    CommentBottomSheet()
}


struct CommentViewCell : View {
    let user:User
    var body: some View {
        
        VStack{
            //User Info
            HStack {
                UserInfo(user: user, imageSize: .xsmall)
                    .padding(10)
                Buttons.actionButton(buttonType: .liked, action: {
                    
                }, getNumber: 10)
                .padding(.all,10)
                
            }
            Text("benim şahane ötesi fikirlerimi beğenip beğenmemek size mi düştü arkadaşlar ben istediğimi yazar çizerim bu size alakadar etmez anladınız mı")
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal)
                .padding(.vertical,5)
        }
        .frame(width: Const.width * 0.95)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 0.5)
        )
    }
}
