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
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .padding(.trailing,10)
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
                CircleProfileImage(userIamgeUrl: "", size: .xxsmall)
                    .padding(.horizontal,10)
                VStack(alignment:.leading){
                    Text(user.username)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                        
                    Text("\(user.name) \(user.surName)").font(.caption2).fontWeight(.semibold)
                }
                Text("4h")
                    .opacity(0.6)
                    .font(.footnote)
                    .padding(.horizontal,5)
                Spacer()
                ActionButton(button: .liked, number: 10, action: {})
                    .padding(.all,10)
                
            }
            Text("benim şahane ötesi fikirlerimi beğenip beğenmemek size mi düştü arkadaşlar ben istediğimi yazar çizerim bu size alakadar etmez anladınız mı")
                .font(.caption)
                .fontWeight(.bold)
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
