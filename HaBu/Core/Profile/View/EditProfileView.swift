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
            
            VStack {
                Text("HaBu")
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("150").frame(height: 45)
                
                }
            }
            .frame(width: Const.width * 1, height: Const.height * 0.2)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.36, green: 0.51, blue: 0.57)]), startPoint: .topLeading, endPoint: .leading).rotationEffect(Angle(degrees: 220)).frame(width: Const.width * 1.15, height: Const.height * 0.5).shadow(radius: 10))
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        myText(text: "İsim")
                        Spacer()
                    }.frame(width: Const.width * 0.8)
                    myTextField(placeholder: "İsminizi girin \(name)", text: $name)
                    Divider().frame(width: 330).background(Color.black)
                    
                }
                
            }
            
            HStack {
                VStack {
                    HStack {
                        myText(text: "Soyisim")
                        Spacer()
                    }.frame(width: Const.width * 0.8)
                    myTextField(placeholder: "Soyisminiz girin \(surName)", text: $surName)
                    Divider().frame(width: 330).background(Color.black)
                    
                }
                
            }
            
            HStack {
                VStack {
                    HStack {
                        
                        myText(text: "Email")
                        Image(systemName: "lock.fill").frame(height: Const.height * 0.02).foregroundColor(.red).opacity(0.7)
                        Spacer()
                    }.frame(width: Const.width * 0.8)
                    Text("202413709033@ogrbalikesiredutr\(email)").frame(width: Const.width * 0.8, height: Const.height * 0.03)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            HStack{
                VStack{
                    HStack {
                        myText(text: "Biografi")
                        Spacer()
                    }.frame(width: Const.width * 0.8)
                    myTextField(placeholder: "Biyografi girin\(biyografi)", text: $biyografi)
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
                        .background(Color(red: 0.2, green: 0.3, blue: 0.7))
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
struct myTextField: View {
    var placeholder: String
    @Binding var text: String
    init (placeholder: String, text: Binding<String>){
        self.placeholder = placeholder
        self._text = text
    }
    var body: some View {
        TextField(placeholder, text: $text)
            .frame(width: Const.width * 0.8, height: Const.height * 0.03)
    }
}


#Preview {
    EditProfileView()
}
