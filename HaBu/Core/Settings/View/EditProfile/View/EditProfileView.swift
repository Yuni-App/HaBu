//
//  EditProfileView.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct EditProfileView: View {
     var user: User
    
    @Environment(\.dismiss) var dismiss
    @StateObject var editProfileVM : EditProfileViewModel
    init(user:User){
        self.user = user
        self._editProfileVM = StateObject(wrappedValue: EditProfileViewModel(user: user))
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
                            Text("Yuni").foregroundStyle(.white).font(.custom("Kodchasan-Bold", size: 35))
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
                                
                                CircleProfileImage(userImage:editProfileVM.images[0] , index: editProfileVM.imageIndices[0])
                                
                                CircleProfileImage(userImage: editProfileVM.images[1] , index: editProfileVM.imageIndices[1])
                                CircleProfileImage(userImage:editProfileVM.images[2] , index: editProfileVM.imageIndices[2])
                            }
                            .frame(width: Const.width)
                            .gesture(editProfileVM.dragGesture)
                            
                        }
                        
                    }
                    
                    
                }.frame(maxHeight: Const.height * 0.35) // Üçgen Yapı
                
               //isim
                TextFields.CustomTextField2(headline: "İsim", color: .white, islocked: false, text: $editProfileVM.textName, placeHolder: "İsminizi Giriniz", contentType: .name, keybordType: .namePhonePad)
                 //soyisim
                TextFields.CustomTextField2(headline: "Soyisim", color: .white, islocked: false, text: $editProfileVM.textSurName, placeHolder: "Soyisminiz giriniz", contentType: .familyName, keybordType: .namePhonePad)
                //email
                TextFields.CustomTextField2(headline: "Email", color: .white, islocked: true, text: $editProfileVM.textEmail, placeHolder: "Email adresiniz", contentType: .emailAddress, keybordType: .emailAddress)
                //bio
                TextFields.CustomTextField2(headline: "Biografi", color: .white, islocked: false, text: $editProfileVM.textBio, placeHolder: "Biografinizi giriniz", contentType: .oneTimeCode, keybordType: .default)
                Spacer()
                CustomButton(title: "Kaydet", backgroundColor: Const.thirColor, action: {
                    print(editProfileVM.textName)
                    return false
                }, size: .lage)
            }.frame(width: Const.width * 1)
                .background(Const.primaryColor)
        }
        .navigationBarBackButtonHidden(true)
    }
    
   
    
}


#Preview {
    EditProfileView(user: User.MockData[0])
}


