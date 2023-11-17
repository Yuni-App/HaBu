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
                    }
                    TextField("isminizi girin\(name)", text: $name).frame(width: 300,height: 30)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            
            HStack {
                VStack {
                    HStack {
                        myText(text: "     Soyisim")
                        Spacer()
                    }
                    TextField("Soyisiminizi girin\(surName)", text: $surName).frame(width: 300,height: 30)
                    Divider().frame(width: 330).background(Color.black)
                        
                }
                
            }
            
            HStack {
                VStack {
                    HStack {
                        
                        myText(text: "  Email")
                        Image(systemName: "lock.fill")
                        
                        Spacer()
                    }
                    Text("\(email)").frame(width: 300,height: 30)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            HStack{
                VStack{
                    HStack {
                        myText(text: "    Biografi")
                        Spacer()
                    }
                    TextField("Biyografi girin\(biyografi)", text: $biyografi).frame(width: 300, height: 50)
                    Divider().frame(width: 330).background(Color.black)
                }
            }
            HStack {
                VStack {
                    HStack {
                        myText(text: "Şifre")
                        Spacer()
                    }
                    SecureField("************** \(password)", text:$password ).frame(width: 300,height: 30)
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
            
        }.background(Color(red: 0.33, green: 0.74, blue: 0.72))
        
    }
}

struct myText: View{
    var text: String
    
    init(text: String) {
            self.text = text
                }
    var body: some View{
        Text(text).bold().frame(width: 100).foregroundColor(.white)
    }
}


#Preview {
    EditProfileView()
}
