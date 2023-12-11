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
    static func CommentTextField()-> some View{
        @State var commentText: String = ""
        VStack{
            TextField("Yorum...", text: $commentText)
                .modifier(IGTextFieldModifier())
        }
    }
    
    //add post text field
    @ViewBuilder
    static func LineLimitTextField()-> some View{
        @State var text: String = ""
        VStack {
           TextField("Ne düşünüyorsunuz?", text: $text, axis: .vertical)
               .padding()
               .lineLimit(9...)
               .background(Color.white)
               .cornerRadius(7)
               .shadow(color: Color.black.opacity(0.4), radius: 4, x: 1, y: 2)
       }   .padding(7)
    }
    
    //settings text field
    @ViewBuilder
    static func CustomTextField3 (icon:AppIcon , placeHolder : String)->some View {
        @State var text: String = ""
        VStack {
            VStack {
                TextField("", text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            if text.isEmpty {
                                Image.iconManager(icon, size: 20, weight: .bold, color: .gray)
                                    .padding(.leading, 8)
                                Text(placeHolder)
                                Spacer()
                            }
                        })
            }
        }
    }
    
    struct DCustomTextField2: View {
        let headline : String
        let color: Color
        let islocked : Bool
        var icon: AppIcon?
        var iconColor:Color?
        @Binding var text: String
        var placeHolder : String
        var contentType : UITextContentType
        var keybordType : UIKeyboardType
        var body: some View {
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
                        TextField(placeHolder, text: $text)
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
    }

    //edit profile text field
    @ViewBuilder
    static func CustomTextField2(headline : String , color : Color , islocked : Bool , icon : AppIcon? , iconColor : Color? , placeHolder : String , contentType :UITextContentType, keybordType : UIKeyboardType )-> some View {
        @State var text: String = ""
        
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
                    TextField(placeHolder, text: $text)
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
    static func CustomTextField(icon:AppIcon , placeHolder : String)->  some View {
        @State var text: String = ""
        VStack {
            HStack(alignment: .center) {
                Image.iconManager(icon, size: 15, weight: .bold, color: .white)
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    TextField("", text: $text)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(Const.textFieldColor)
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Const.secondaryColor, lineWidth: 2)
            )
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
    }
    
    
    
    
    
    
    
}

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
