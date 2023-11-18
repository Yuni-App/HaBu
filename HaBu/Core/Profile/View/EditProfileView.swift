//
//  EditProfileView.swift
//  HaBu
//
//  Created by yusuf on 16.11.2023.
//

import SwiftUI

struct EditProfileView: View {
    @State var name : String = ""
    @State var surName : String = ""
    @State var email : String = ""
    @State var biyografi : String = ""
    @State var password: String = ""
    
    
    
    var body: some View {
        
        
        VStack {

            Text("HaBu")
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("150").frame(height: 45)
            }
            
            
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        myText(text: "İsim")
                        Spacer()
                    }.frame(width: Const.width * 0.8)

                    TextField("isminizi girin\(name)", text: $name).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            
            HStack {
                VStack {
                    HStack {
                        myText(text: "Soyisim")
                        Spacer()
                    }.frame(width: Const.width * 0.8)

                    TextField(" Soyisminizi girin\(surName)", text: $surName).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            
            HStack {
                VStack {
                    HStack {
                        
                        myText(text: "Email")
                        Image(systemName: "lock.fill")
                        Spacer()
                    }.frame(width: Const.width * 0.8)
                    Text("\(email)").frame(width: Const.width * 0.8, height: Const.height * 0.03)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            HStack{
                VStack{
                    HStack {
                        myText(text: "Biografi")
                        Spacer()
                    }.frame(width: Const.width * 0.8)
                    TextField("Biyografi girin\(biyografi)", text: $biyografi).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            HStack {
                VStack {
                    HStack {
                        myText(text: "Şifre")
                        Spacer()
                    }.frame(width: Const.width * 0.8)

                    
                    SecureField("************** \(password)", text:$password ).frame(width: Const.width * 0.8, height: Const.height * 0.03)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            Spacer()
            HStack {
                
                Button(action: {}, label: {
                    Text("Kaydet")
                        .frame(width: 100,height: 30)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(5)
                    
                })
            }
            
        }.frame(width: Const.width * 1)
        .background(Color(red: 0.33, green: 0.74, blue: 0.72))
        
    }
}

struct myText: View{
    var text: String
    
    init(text: String) {
            self.text = text
                }
    var body: some View{
        Text(text).bold().foregroundColor(.white)
    }
}


#Preview {
    EditProfileView()
}
