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
    @EnvironmentObject var navigation:NavigationStateManager
    
    var body: some View {
        NavigationView{
            ZStack{
                AddPostBackground()
                VStack{
                    FeedBackBar().frame(height: Const.height * 0.1)
                    
                    VStack {
                        Image("Feed 1")
                            .padding()
                        TextField("Ne düşünüyorsunuz?", text: $text, axis: .vertical)
                            .padding()
                            .lineLimit(9...)
                            .background(Color.white)
                            .cornerRadius(7)
                            .shadow(color: Color.black.opacity(0.4), radius: 4, x: 1, y: 2)
                        Spacer()
                    }.padding(7)
                    VStack{
                        Rate(selectedRating: $selectedRating)
                    }
                    .frame(width: Const.width * 0.9, height: Const.height * 0.3)
                    
                    
                    VStack {
                        SendButton(text: text)
                    }.padding()
                        .frame(width: Const.width * 0.4)
                    
                }.padding()
                Spacer()
            }
        }
    }
}


#Preview {
    FeedBackInput()
}


@ViewBuilder
func FeedBackBar() -> some View {
    @EnvironmentObject var navigation: NavigationStateManager
    HStack {
        Buttons.backButton {
            navigation.pop()
        }
        
        Spacer()
        Text("Geri Bildirim")
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .frame(width: Const.width * 0.5)
        Spacer()
    }
    .padding(.top, 55)
}

@ViewBuilder
func SendButton(text: String) -> some View {
    @EnvironmentObject var navigation: NavigationStateManager
    HStack {
        if !text.isEmpty {
        
                Text("GÖNDER")
                    .fontWeight(.semibold)
                    .frame(width: Const.width * 0.5, height: Const.height * 0.05, alignment: .center)
                    .foregroundColor(.white)
                    .background(Const.primaryButtonColor)
                    .cornerRadius(8)
                    .opacity(text.isEmpty ? 0.7 : 1.0)
                    .onTapGesture {
                        navigation.push(.settings(.feedBackSuccess))
                    }
                    
            }
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


