//
//  EditProfileView.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct EditProfileView: View {
    var user: User
    @State private var textName : String = ""
    @State private var textSurName : String = ""
    @State private var textEmail : String = ""
    @State private var textBiyografi : String = ""
    @State private var textPassword: String = ""
    @State private var dragDirection: DragDirection = .none
    @State private var imageIndices = [0, 1, 2]
    @State private var imagePickerPresented = false
    @Environment(\.dismiss) private var dismiss
    var images = [
        "profil1",
        "profil2",
        "profil3"
    ]
    init(user:User){
        self.user = user
    }
    var body: some View {
        
        VStack {
            
            VStack {
                
                ZStack {
                    Rectangle()
                        .frame(width: Const.height * 0.52,height: Const.height * 0.52)
                        .foregroundStyle(Const.thirColor)
                        .border(Const.primaryColor)
                        .rotationEffect(Angle(degrees: 45))
                        .position(x:Const.width / 2 ,y:-Const.height * 0.1)
                        .shadow(color: Color.black.opacity(0.4), radius: 7, x: 5, y:20)
                    
                    VStack{
                        HStack {
                            Buttons.backButton(action: {
                                
                                dismiss.callAsFunction()

                            }, color: .white) 
                            
                            .padding(.leading)
                            Spacer()
                            Text("HaBu!").foregroundStyle(.white).font(.custom("IrishGrover-Regular", size: 35))
                                .padding(.trailing)
                            Spacer()


                        }
                        HStack {
                            Image("star")
                            Text("150")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        Text(user.username)
                        
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        //profile Images
                        HStack {
                            ZStack{
                                
                                CircleProfileImage(userImage: images[0] , index: imageIndices[0])
                                CircleProfileImage(userImage: images[1] , index: imageIndices[1])
                                CircleProfileImage(userImage: images[2] , index: imageIndices[2])
                            }
                            .frame(width: Const.width)
                            .gesture(dragGesture)
                            
                        }
                        
                    }
                    
                    
                }.frame(maxHeight: Const.height * 0.35) // Üçgen Yapı
                
               //isim
                TextFields.CustomTextField2(headline: "İsim", color: .white, islocked: false, text: $textName, placeHolder: "İsminizi Giriniz", contentType: .name, keybordType: .namePhonePad)
                 //soyisim
                TextFields.CustomTextField2(headline: "Soyisim", color: .white, islocked: false, text: $textSurName, placeHolder: "Soyisminiz giriniz", contentType: .familyName, keybordType: .namePhonePad)
                //email
                TextFields.CustomTextField2(headline: "Email", color: .white, islocked: true, text: $textEmail, placeHolder: "Email adresiniz", contentType: .emailAddress, keybordType: .emailAddress)
                //bio
                TextFields.CustomTextField2(headline: "Biografi", color: .white, islocked: false, text: $textBiyografi, placeHolder: "Biografinizi giriniz", contentType: .oneTimeCode, keybordType: .default)
                Spacer()
                CustomButton(title: "Kaydet", backgroundColor: Const.thirColor, action: {
                    false
                }, size: .lage)
            }.frame(width: Const.width * 1)
                .background(Const.primaryColor)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var dragGesture: some Gesture {
          DragGesture()
              .onChanged(onDragChanged)
              .onEnded(onDragEnded)
      }
    private func onDragChanged(value: DragGesture.Value) {
            let direction: DragDirection = value.translation.width > 1 ? .right : .left
            if dragDirection != direction{
                withAnimation{
                    dragDirection = direction
                    if dragDirection   == .left{
                        incrementImageIndices(&imageIndices,shouldIncrement: false)
                    }
                    else if dragDirection == .right{
                        incrementImageIndices(&imageIndices,shouldIncrement: true)
                        
                        
                    }
                }
            }
        
      }
    private func onDragEnded(value: DragGesture.Value) {
        dragDirection = .none
       }
    
}


#Preview {
    EditProfileView(user: User.MockData[0])
}

private func incrementImageIndices(_ indices: inout [Int],shouldIncrement: Bool) {
    for i in 0..<indices.count {
           if shouldIncrement {
               indices[i] += 1
               if indices[i] > 2 {
                   indices[i] = 0
               }
           } else {
               indices[i] -= 1
               if indices[i] < 0{
                   indices[i] = 2
               }
           }
       }
}
