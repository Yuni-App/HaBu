//
//  FeedBackInput.swift
//  HaBu
//
//  Created by yusuf on 6.12.2023.
//

import SwiftUI
import Combine

struct FeedBackInput: View {
    @ObservedObject var viewModel = FeedBackInputViewModel()
    
    @State private var text : String = ""
    @State private var selectedRating: Int = 0
    @Environment(\.dismiss) private var dismiss
    @State private var isActiveDestination: Bool = false
    @State private var keyboardHeight: CGFloat = 0
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
                        .ignoresSafeArea(.keyboard)
                    Image("Feed 1")
                        .padding()
                    TextFields.LineLimitTextField(text: $viewModel.text)
                    Spacer()
                    Rate(viewModel: viewModel)
                    Spacer()
                    SendButton(viewModel: viewModel, isActiveDestinationBinding: $isActiveDestination).padding(.bottom, Const.height * 0.05)
                    
                }.navigationDestination(isPresented: $isActiveDestination, destination: {
                    FeedBackSuccess()
                })
                .frame(width: Const.width * 0.95)
            }
            .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                self.keyboardHeight = keyboardHeight // Klavye yüksekliğini güncelliyoruz
            }
            .padding(.top, keyboardHeight*0.9).animation(.easeOut(duration: 0))
            .frame(height: Const.height * 1).navigationBarBackButtonHidden(true)
            .hideKeyboardOnTap()
            
    }
}


#Preview {
    FeedBackInput()
}

@ViewBuilder
func SendButton(viewModel: FeedBackInputViewModel, isActiveDestinationBinding: Binding<Bool>) -> some View {
    HStack {
        Button(action: {
            viewModel.submitFeedback()
            withAnimation {
                    isActiveDestinationBinding.wrappedValue = true
                  }
        }) {
            Text("GÖNDER")
                .fontWeight(.semibold)
                .frame(width: Const.width * 0.5, height: Const.height * 0.05, alignment: .center)
                .foregroundColor(.white)
                .background(Const.primaryButtonColor)
                .cornerRadius(8)
                .opacity(viewModel.text.isEmpty ? 0.7 : 1.0)
        }
        .disabled(viewModel.text.isEmpty)
        .padding(.top, 10) // İsteğe bağlı: Görsel olarak daha iyi bir görünüm için
    }
}

@ViewBuilder
func Rate(viewModel: FeedBackInputViewModel) -> some View {
    HStack {
        ForEach(1...5, id: \.self) { index in
            Image(systemName: viewModel.selectedRating >= index ? "star.fill" : "star")
                .resizable()
                .frame(width: Const.width * 0.1, height: Const.height * 0.05)
                .foregroundColor(viewModel.selectedRating >= index ? Color.yellow : Color.gray.opacity(0.4))
                .onTapGesture {
                    viewModel.selectedRating = index
                }
                .animation(.easeInOut(duration: 0.2))
                .opacity(viewModel.selectedRating == index ? 1.0 : 0.7)
        }
    }
}


/*
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
*/

