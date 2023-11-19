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
    @State var imagePickerPresented = false

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
                
                ZStack {
                    Rectangle()
                        .frame(width: Const.height * 0.5,height: Const.height * 0.5)
                        .foregroundStyle(Const.thirColor)
                        .rotationEffect(Angle(degrees: 45))
                        .position(x:Const.width / 2 ,y:-Const.height * 0.1)
                    
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
                        
                       
                        //profile Images
                        HStack {
                            ZStack{
                                
                        CircleProfileImage(userImage: images[0] , index: imageIndices[0])
                        CircleProfileImage(userImage: images[1] , index: imageIndices[1])
                        CircleProfileImage(userImage: images[2] , index: imageIndices[2])
                            }
                            .frame(width: Const.width)
                            .gesture(DragGesture().onChanged({ value in
                                print(value.translation.width)
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
                            })
                                .onEnded({ value in
                                    dragDirection = .none
                                })
                            )
                            
                        }
                        
                    }
                   
                    
                }.frame(maxHeight: Const.height * 0.35) // Üçgen Yapı
                               
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
                                .opacity(0.4)
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

