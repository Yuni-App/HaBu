//
//  FeedBackInput.swift
//  HaBu
//
//  Created by yusuf on 6.12.2023.
//

import SwiftUI

struct FeedBackInput: View {
    @State private var text : String = ""
    @State private var isAnonimPost = false
    @State private var isAnonimComment  = false
    @State private var selectedRating: Int = 0
    @Environment(\.dismiss) private var dismiss
    var body: some View {
            ZStack{
                AddPostBackground()
                VStack {
                    HStack {
                        Buttons.backButton(action: {
                            dismiss()
                        })
                        Text("Geri Bildirim")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: Const.width * 0.9)
                    }.frame(width: Const.width * 1).padding(.top, 40)
                    Image("Feed 1")
                        .padding()
                    //PopUp(size: .lage, backgroundColor: .brown, contents: "merhaba", btnOpen: "aç", btnClose: "kapat")
                    TextFields.LineLimitTextField(text: $text)
                    Spacer()
                    Rate(selectedRating: $selectedRating)
                    Spacer()
                    SendButton(text: text).padding(.bottom, Const.height * 0.05)
                }.frame(width: Const.width * 0.95)
            }.frame(height: Const.height * 1).navigationBarBackButtonHidden(true)
    }
}


#Preview {
    FeedBackInput()
}

@ViewBuilder
func SendButton(text: String) -> some View {
    HStack {
        NavigationLink(
            destination: FeedBackSuccess(),
            label: {
                Text("GÖNDER")
                    .fontWeight(.semibold)
                    .frame(width: Const.width * 0.5, height: Const.height * 0.05, alignment: .center)
                    .foregroundColor(.white)
                    .background(Const.primaryButtonColor)
                    .cornerRadius(8)
                    .opacity(text.isEmpty ? 0.7 : 1.0)
            }
        )
        .disabled(text.isEmpty)
    }
}


@ViewBuilder
func Rate(selectedRating: Binding<Int>) -> some View {
    HStack {
        ForEach(1...5, id: \.self) { index in
            Image(systemName: selectedRating.wrappedValue >= index ? "star.fill" : "star")
                .resizable()
                .frame(width: Const.width * 0.1, height: Const.height * 0.05)
            
                .foregroundColor(selectedRating.wrappedValue >= index ? Color.yellow : Color.gray.opacity(0.4))
                .onTapGesture {
                    selectedRating.wrappedValue = index
                }.animation(.easeInOut(duration: 0.2))
                .opacity(selectedRating.wrappedValue == index ? 1.0 : 0.7)
        }
    }
}


