//
//  AddPostTView.swift
//  HaBu
//
//  Created by mert alp on 2.12.2023.
//

import SwiftUI

struct AddPostView: View {
    @State private var text : String = ""
    @State private var isAnonimPost = false
    @State private var isAnonimComment  = false
  
   
    var body: some View {
        
        NavigationStack{
            ZStack{
                AddPostBackground()
                
                VStack{
                    AddPostAppBar()
                    VStack {
                        
                        TextField("Ne düşünüyorsunuz?", text: $text, axis: .vertical)
                            .padding()
                            .lineLimit(9...)
                            .background(Color.white)
                            .cornerRadius(7)
                            .shadow(color: Color.black.opacity(0.4), radius: 4, x: 1, y: 2)
                    }   .padding(7)
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
                        .background( RoundedRectangle(cornerRadius: 7)
                            .foregroundColor(Color.white))
                        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 1, y: 2)
                    AddPostMedia()
                    Spacer()
                }.padding()
                
            }
            
        }
    }
}

#Preview {
    AddPostView()
}

struct AddPostAppBar: View {
    var body: some View {
        HStack{
            Image(systemName: "arrow.left.circle")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .frame(width: Const.width/7)
            Spacer()
            Text("Gönderi Oluştur")
                .foregroundColor(.white)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("Paylaş")
                .foregroundColor(.green)
                .fontWeight(.bold)
                .frame(width: Const.width/7)
        }.padding(.top , 25)
    }
}

struct AddPostBackground: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: Const.height * 2.5 / 10)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(UIColor(hex: "04243E")), location: 0.00),
                            Gradient.Stop(color: Color(UIColor(hex: "100F42")).opacity(0.49), location: 0.51),
                            Gradient.Stop(color: Color(UIColor(hex: "100F34")).opacity(0.89), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            Color(UIColor(hex: "F3F3F3"))
                .frame(height: Const.height * 7.6 / 10)
        }
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

struct AddPostMedia: View {
    var imageList  : [String] = ["Mert","Mert"]
    var body: some View {
        VStack{
            HStack{
                Text("Medya")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack{
                if imageList.isEmpty {
                    GenerateImageBox(buttonsheet: false, image: "AddPhoto" )
                    Spacer()
                }
                if imageList.count == 3 {
                    ForEach(imageList, id: \.self) { userImage in
                        //Image box
                        GenerateImageBox(buttonsheet: false, image: userImage)
                        Spacer()
                    }
                }
                if imageList.count == 2 {
                    ForEach(imageList, id: \.self) { userImage in
                        //Image box
                        GenerateImageBox(buttonsheet: false, image: userImage)
                        Spacer()
                        
                    }
                    GenerateImageBox(buttonsheet: true, image: "AddPhoto")
                    Spacer()
                }
                if imageList.count == 1 {
                    ForEach(imageList, id: \.self) { userImage in
                        //Image box
                        GenerateImageBox(buttonsheet: false, image: userImage)
                    }
                    GenerateImageBox(buttonsheet: true, image: "AddPhoto")
                    Spacer()
                }
            }
        }.padding(.bottom, 30)
    }
}
