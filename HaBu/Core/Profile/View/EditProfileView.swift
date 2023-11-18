//
//  EditProfileView.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct EditProfileView: View {
    var user : User
    @State var name : String = ""
    @State var surName : String = ""
    @State var email : String = ""
    @State var biyografi : String = ""
    @State var password: String = ""
    @State private var dragDirection: DragDirection = .none
    @State private var imageIndices = [0, 1, 2]
    @State private var images = [
    "flutter",
    "swiftLogo",
    "react"
    ]
    init(user:User){
        self.user = user
    }
    var body: some View {
        
        
            VStack {
                
                ZStack {
                    Rectangle()
                        .frame(width: Const.height * 0.4,height: Const.height * 0.4)
                        .foregroundStyle(Const.thirColor)
                        .rotationEffect(Angle(degrees: 45))
                    .position(x:Const.width / 2 ,y:0)
                    
                    VStack{
                        Text("HaBu!").foregroundStyle(.white).font(.custom("IrishGrover-Regular", size: 35))
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
                        
                        Spacer()
                    }
                    
                    
                }.frame(height: Const.height * 0.35) // Üçgen Yapı
                               
                HStack {
                    VStack {
                        HStack {
                            myText(text: "İsim")
                            Spacer()
                        }.frame(width: Const.width * 0.8)

                        TextField("isminizi girin\(name)", text: $name).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                        Divider().frame(width: 330).background(Color.black)
                            
                    }
                    
                } //isim
                
                HStack {
                    VStack {
                        HStack {
                            myText(text: "Soyisim")
                            Spacer()
                        }.frame(width: Const.width * 0.8)

                        TextField(" Soyisminizi girin\(surName)", text: $surName).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                        Divider().frame(width: 330).background(Color.black)
                            
                    }
                    
                } //soyisim
                
                HStack {
                    VStack {
                        HStack {
                            
                            myText(text: "Email")
                            Image(systemName: "lock.fill")
                            Spacer()
                        }.frame(width: Const.width * 0.8)
                        TextField("Mail Adresiniz\(email)", text: $email).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                        Divider().frame(width: 330).background(Color.black)
                    }
                } //email
                HStack{
                    VStack{
                        HStack {
                            myText(text: "Biografi")
                            Spacer()
                        }.frame(width: Const.width * 0.8)
                        TextField("Biyografi girin\(biyografi)", text: $biyografi).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                        
                        Divider().frame(width: 330).background(Color.black)

                    }
                    
                } //bio
                Spacer()
                CustomButton(title: "Kaydet", backgroundColor: Const.thirColor) {
                    print("kaydet")
                }
                
            }.frame(width: Const.width * 1)
                .background(Const.primaryColor)
        }
    }

struct myText: View{
    var text: String
    
    init(text: String) {
            self.text = text
                }
    var body: some View{
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.headline)
        
    }
}


#Preview {
    EditProfileView(user: User.MockData[0])
}
