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
    var body: some View {
        NavigationView{
            ZStack{
                AddPostBackground()
                    VStack {
                        FeedBackBar().frame(height: Const.height * 0.15)
                        Image("Feed 1")
                            .padding()
                        TextField("Ne düşünüyorsunuz?", text: $text, axis: .vertical)
                            .padding()
                            .lineLimit(9...)
                            .background(Color.white)
                            .cornerRadius(7)
                            .shadow(color: Color.black.opacity(0.4), radius: 4, x: 1, y: 2)
                        Spacer()
                        Rate(selectedRating: $selectedRating)
                        Spacer()
                        SendButton(text: text).padding(.bottom, Const.height * 0.05)
                    }.frame(width: Const.width * 0.95)
                
            }
        }.frame(height: Const.height * 1)
    }
}


#Preview {
    FeedBackInput()
}


@ViewBuilder
func FeedBackBar() -> some View {
    HStack {
        NavigationLink {
            SettingsView().navigationBarBackButtonHidden()
        } label: {
            Image(systemName: AppIcon.back.rawValue).resizable().frame(width: Const.width * 0.03, height: Const.height * 0.025).foregroundStyle(Color.black)
        }
            Text("Geri Bildirim")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(width: Const.width * 0.9)
    }.frame(width: Const.width * 1)
}

@ViewBuilder
func SendButton(text: String) -> some View {
    HStack {
        NavigationLink(
            destination: FeedBackSuccess().navigationBarBackButtonHidden(),
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


