//
//  CreatePost.swift
//  HaBu
//
//  Created by mert alp on 17.11.2023.
//

import SwiftUI
struct CreatePostView: View {
    var imageList  : [String] = ["Mert","Mert"]
    @State private var text: String = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment : .leading) {
                    Text("Medya").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.horizontal ,15)
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: Const.width , height: 130)
                            .background(
                                Image("")
                                    .resizable()
                                    .foregroundColor(.white).background(Color(red: 1, green: 1, blue: 1).opacity(0.1))
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(1), radius: 0, x: 4, y:4)
                            )
                        HStack{
                            if imageList.isEmpty {
                                GenerateImageBox(image: "AddPhoto")
                            }
                            if imageList.count == 3 {
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(image: userImage)
                                 }
                            }
                            if imageList.count == 2 {
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(image: userImage)
                                 }
                                GenerateImageBox(image: "AddPhoto")
                            }
                            if imageList.count == 1 {
                                ForEach(imageList, id: \.self) { userImage in
                                    //Image box
                                    GenerateImageBox(image: userImage)
                                 }
                                GenerateImageBox(image: "AddPhoto")
                            }
                        }
                    }
                    
                    //TEXT FİELD
                    VStack {
                               TextField("Ne düşünüyorsunuz?", text: $text)
                                   .padding()
                                   .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                           }   .padding()
                }
            }

            
            
            .toolbar{
                /*ToolbarItem(placement: .principal) {
                    Text("Gönderi Oluştur").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }*/
                /*
                ToolbarItem(placement: .topBarLeading){
                    Button(action: {
                        
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundStyle(.black)


                    })
                }*/
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                    }, label: {
                        NavigationLink(destination: AddFilterView()) {
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Const.primaryColor)
                        }
                            
                         
                        

                    })
                }
            }
        }
    }
}

#Preview {
    CreatePostView()
}

struct GenerateImageBox: View {
    @State private var addPhotoBottomSheet: Bool = false
    let image: String

    var body: some View {
        Button(action: {
            addPhotoBottomSheet = true
            print("Tapped")
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 100)
                    .background(
                        Image(image)
                            .resizable()
                            .sheet(isPresented: $addPhotoBottomSheet) {
                                
                                Text("bottom sheet ")
                                    .presentationDetents([.medium,.height(CGFloat(Const.height/4 + 10))])
                            }
                            .foregroundColor(.white)
                            .background(Color(red: 0.65, green: 0.65, blue: 0.65).opacity(0.1))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(1), radius: 5, x: 4, y: 4)
                    )
                CustomImageRectangle(width: 100, height: 100, imagePath: "").frame(width: 100, height: 100)
            }
        }
    }
}
