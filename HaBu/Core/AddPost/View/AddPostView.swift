//
//  AddPostTView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct AddPostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var textContent : String = ""
    @State private var isAnonimPost = false
    @State private var isAnonimComment  = false
    
    var body: some View {
            ZStack{
                AddPostBackground()
                VStack{
                    AddPostAppBar {
                        dismiss()
                    }
                    TextFields.LineLimitTextField(text: $textContent)
                    AddPostCategory()
                    HStack{
                        Toggle("Anonim Gönderi", isOn: $isAnonimPost)
                            .fontWeight(.bold)
                    }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .foregroundColor(Color.white))
                        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 1, y: 2)
                    HStack{
                        Toggle("Anonim Yorum", isOn: $isAnonimComment)
                            .fontWeight(.bold)
                    }.padding()
                        .background(RoundedRectangle(cornerRadius: 7)
                            .foregroundColor(Color.white))
                        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 1, y: 2)
                    AddPostMedia()
                    Spacer()
                }.padding()
                
            }
            
        
    }
}

#Preview {
    AddPostView()
}
@ViewBuilder
func AddPostAppBar(action : @escaping()->Void) -> some View{
    
    HStack{
        Buttons.backButton {
                action()
        }
        Spacer()
        Text("Gönderi Oluştur")
            .foregroundColor(.white)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        Spacer()
        NavigationLink(destination: TabbarView().navigationBarBackButtonHidden(true)) {
            Text("Paylaş")
                .foregroundColor(.green)
                .fontWeight(.bold)
                .frame(width: Const.width/7)
        }
    }.padding(.top , 25)
}

@ViewBuilder
func AddPostBackground()-> some View {
    VStack(spacing: 0) {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: Const.height * 2.5 / 10)
            .background(
                Const.LinearBackGroundColor
            )
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        
        Const.primaryBackGroundColor
            .frame(height: Const.height * 7.6 / 10)
    }
}


struct AddPostCategory: View {
    @State var SelectedTags:[String] = []
    @Namespace private var animation
    var body: some View {
        VStack{
            HStack{
                Text("Kategori")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(SelectedTags ,id: \.self){tag in
                        TagView(tag, Const.thirColor, "checkmark")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    SelectedTags.removeAll(where: {$0 == tag})
                                }
                            }
                        
                    }
                }
                .padding(.horizontal,15)
                .frame(height: 35)
                .padding(.vertical,15)
            }
            .overlay {
                if SelectedTags.isEmpty{
                    Text("Şeçilen Kategoriler")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    
                }
            }
            .background(.white)
            .zIndex(1)
            ScrollView(.vertical){
                TagLayout(spacing: 10){
                    ForEach(Const.categoryTags.filter{!SelectedTags.contains($0)} , id: \.self){tag in
                        TagView(tag, Const.primaryColor, "plus")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    SelectedTags.insert(tag, at: 0)
                                }
                            }
                    }
                }
                .padding(15)
            }
        }
    }
}

@ViewBuilder
func AddPostMedia(imageList : [String] = ["Mert","Mert"] )-> some View {
    VStack{
        HStack{
            Text("Medya")
                .foregroundColor(.black)
                .fontWeight(.bold)
            Spacer()
        }
        HStack{
            if imageList.isEmpty {
                GenerateImageBox(image: "AddPhoto" )
                Spacer()
            }
            if imageList.count == 3 {
                ForEach(imageList, id: \.self) { userImage in
                    //Image box
                    GenerateImageBox( image: userImage)
                    Spacer()
                }
            }
            if imageList.count == 2 {
                ForEach(imageList, id: \.self) { userImage in
                    //Image box
                    GenerateImageBox( image: userImage)
                    Spacer()
                    
                }
                GenerateImageBox(image: "AddPhoto")
                Spacer()
            }
            if imageList.count == 1 {
                ForEach(imageList, id: \.self) { userImage in
                    //Image box
                    GenerateImageBox(image: userImage)
                }
                GenerateImageBox(image: "AddPhoto")
                Spacer()
            }
        }
    }.padding(.bottom, 30)
}

