//
//  TextFields.swift
//  HaBu
//
//  Created by mert alp on 4.12.2023.
//

import Foundation
import SwiftUI

class TextFields {
    //comment text field modifier
    @ViewBuilder
    static func CommentTextField(commentText : Binding<String>)-> some View{
        VStack{
            TextField("Yorum...", text: commentText)
                .modifier(IGTextFieldModifier())
        }
    }
    
    //add post text field
    @ViewBuilder
    static func LineLimitTextField(text:Binding<String>)-> some View{
        VStack {
           TextField("Ne düşünüyorsunuz?", text: text, axis: .vertical)
               .padding()
               .lineLimit(9...)
               .background(Color.white)
               .cornerRadius(7)
               .shadow(color: Color.black.opacity(0.4), radius: 4, x: 1, y: 2)
       }   .padding(7)
    }
    
    //settings text field
    @ViewBuilder
    static func CustomTextField3 ( text: Binding<String> , icon:AppIcon , placeHolder : String)->some View {
        VStack {
            HStack{
                Image.iconManager(icon, size: 15, weight: .bold, color: .white).padding(.leading,10)
                ZStack(alignment: .leading) {
                    TextField(placeHolder, text: text)
                        .padding(.vertical,15)
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
    //edit profile text field
    @ViewBuilder
    static func CustomTextField2(headline : String , color : Color , islocked : Bool , icon : AppIcon? = nil , iconColor : Color? = nil ,text:Binding<String>, placeHolder : String , contentType :UITextContentType , keybordType : UIKeyboardType )-> some View {
        HStack {
            VStack {
                HStack {
                    Text(headline)
                        .foregroundColor(color)
                        .fontWeight(.bold)
                        .font(.headline)
                    if let icon = icon{
                        Image.iconManager(icon, size: 16, weight: .semibold, color: iconColor ?? .white)
                    }
                    Spacer()
                }
                HStack {
                    if islocked == true{
                        Image.iconManager(.lock, size: 16, weight: .semibold, color: iconColor ?? .white)
                    }
                    TextField(placeHolder, text: text)
                        .textContentType(contentType)
                        .keyboardType(keybordType)
                        .disabled(islocked)
                }
                Divider().frame(width: 330).background(Color.black)
            }
            .frame(width: Const.width * 0.85)
            .padding()
        }
    }
    //register text field
    @ViewBuilder
    static func CustomTextField(text : Binding<String>,icon:AppIcon , placeHolder : String)->  some View {
        VStack {
            HStack(alignment: .center) {
                Image.iconManager(icon, size: 15, weight: .bold, color: .black)
                ZStack(alignment: .leading) {
                    if text.wrappedValue.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(.black.opacity(0.6))
                    }
                    TextField("", text: text)
                        .foregroundColor(.black)
                }
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(Const.whiteColor)
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
    }
    @ViewBuilder
    static func CustomTextFieldSecure(text : Binding<String>,icon:AppIcon , placeHolder : String, hidden: Binding<Bool>)->  some View {
        VStack {
            HStack(alignment: .center) {
                Image.iconManager(icon, size: 15, weight: .bold, color: .black)
                ZStack(alignment: .leading) {
                    if text.wrappedValue.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(.black.opacity(0.6))
                    }
                    if hidden.wrappedValue {
                        SecureField("", text: text)
                            .foregroundColor(.black)
                    } else {
                        TextField("", text: text)
                            .foregroundColor(.black)
                    }
                }
                Button(action: {
                    hidden.wrappedValue.toggle()
                }) {
                    Image(systemName: hidden.wrappedValue ? "eye.fill" : "eye.slash")
                        .foregroundColor(.black)
                }
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(Const.whiteColor)
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
    }
    @ViewBuilder
    static func CustomTitle(text: String, size: Int) -> some View{
        Text(text).font(.custom("Baloo2-Bold", size: CGFloat(size))).foregroundStyle(.white)
    }
    @ViewBuilder
    static func CustomText(text: String, color: Color, size: Int) -> some View{
        Text(text).foregroundStyle(color).font(.system(size: CGFloat(size)))
    }
    @ViewBuilder
    static func CustomTextBold(text: String, color: Color, size: Int) -> some View{
        Text(text).foregroundStyle(color).fontWeight(.bold).font(.system(size: CGFloat(size)))
    }
 
}








//example text fields
/*
 VStack {
 TextField("Ne düşünüyorsunuz?", text: $text)
 .padding()
 .background(Color.gray.opacity(0.2))
 .cornerRadius(10)
 .frame(height: UIScreen.main.bounds.height / 3)
 }
 .padding()
 
 
 */

/*
 TextField("Email", text: $text)
 .frame(height: 235)
 .textFieldStyle(PlainTextFieldStyle())
 .padding([.horizontal], 4)
 .background(Color.gray.opacity(0.2))
 .cornerRadius(4)
 .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
 .lineLimit(5)
 */
