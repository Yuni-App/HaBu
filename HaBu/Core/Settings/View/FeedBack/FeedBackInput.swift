//
//  FeedBackInput.swift
//  HaBu
//
//  Created by yusuf on 6.12.2023.
//

import SwiftUI

struct FeedBackInput: View {
    @State private var text : String = ""
    @State private var selectedRating: Int = 0
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
    
            VStack {
                ZStack{
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: Const.height * 0.3)
                            .background(
                                Const.LinearBackGroundColor
                            )
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        Const.primaryBackGroundColor
                            .frame(height: Const.height * 7.6 / 10)
                    }
                    ScrollView{
                        VStack {
                            CustomSettingsTollBar(action: {
                                dismiss()
                            }, title: "Geri Bildirim" , backgroundColor : .clear)
                            
                            Image.imageManager(image: .feedBack).frame(width: Const.width * 0.3 ,height: Const.width * 0.3)
                            TextFields.LineLimitTextField(text: $text)
                            Spacer()
                            Rate(selectedRating: $selectedRating)
                            Spacer()
                            Spacer()
                            Spacer()
                            Buttons.customButton(title: "Gönder", backgroundColor: Const.primaryButtonColor, action: {
                                true
                            }, destination: AnyView(TabbarView()), size: CustomButtonSize.medium)
                  
                            Spacer()
                        }
                        .frame(width: Const.width , height: Const.height)
                        .padding(.top , 65)
                        

                        
                    }
                       
                }
            }.navigationBarBackButtonHidden(true)
        
   
    }
}


#Preview {
    FeedBackInput()
}

/*
 @ViewBuilder
 func FeedBackBar(action: @escaping () -> Void) -> some View {
     HStack {
             Buttons.backButton(action: {
                 action()
             })
             Text("Geri Bildirim")
                 .foregroundColor(.white)
                 .fontWeight(.semibold)
                 .frame(width: Const.width * 0.9)
     }.frame(width: Const.width * 1)
 }
 */
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

 */

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



