//
//  CategoryFilterBottomSheet.swift
//  HaBu
//
//  Created by OmerErbalta on 25.11.2023.
//

import SwiftUI

struct CategoryFilterBottomSheet: View {
    @State var SelectedTags:[String] = []
    @State private var scrollOffset: CGFloat = 0
    @State var dragDirection: DragDirection = .none
    @State var selectedFilter = "Hepsi"
    var body: some View {
        VStack {
            Text("Paylaşım Türü")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Const.thirColor)
            Picker("Please choose a color", selection: $selectedFilter) {
                Text("Anonim")
                    .tag("Anonim")
                Text("Hepsi")
                    .tag("Hepsi")
                Text("Normal")
                    .tag("Normal")
            }
            .pickerStyle(.segmented)   
            
            Divider()
                .padding()
            AddCategoryView(SelectedTags: $SelectedTags)
           
            ZStack{
                Button(action: {
                    
                }, label: {
                    Text("Filtrele")
                        .fontWeight(.semibold)
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .fill(Const.thirColor.gradient)
                        )
                    
                })
                .disabled(SelectedTags.count < 1 )
                .opacity(SelectedTags.count < 1 ? 0.5 : 1)
                .padding(10)
                .foregroundStyle(.white)
                .background(.white)
                .zIndex(2)
            }
        }
    }
}

#Preview {
    CategoryFilterBottomSheet()
}



@ViewBuilder
func TagView(_ tag:String ,_ color: Color, _ icon:String)->some View{
    HStack(spacing:10){
        Text(tag)
            .font(.callout)
            .fontWeight(.semibold)
        Image(systemName:icon)
    }
    .frame(height: 20)
    .foregroundStyle(.white)
    .padding(.horizontal,10)
    .background(
        Capsule().fill(color.gradient)
    )
}
@ViewBuilder
func cardView(_ title:String,_ caption:String,_ color:Color,_ icon:String) -> some View{
    VStack(alignment:.center){
        Rectangle().fill(color)
            .overlay {
                VStack {
                    HStack {
                        Image(icon)
                            .resizable()
                            .frame(width: Const.height * 0.05,height: Const.height * 0.05)
                        Text(title)
                            .font(.headline.bold())
                            .foregroundStyle(.black)
                            .padding()
                    }
                }
            }
    }
    .frame(width: Const.width * 0.6, height:Const.width * 0.15)
    .clipShape(.rect(cornerRadius: 20))
    .padding(.horizontal,Const.width * 0.19)
    
}

struct anonimFilter: Identifiable{
    var id : Int
    var color : Color
    var title : String
    var subTitle : String
    var icon : String
}


struct AddCategoryView : View {
    @Binding var SelectedTags:[String]
    @Namespace private var animation
    var body: some View {
        VStack{
            Text("Kategoriler")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Const.thirColor)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 5){
                    ForEach(SelectedTags ,id: \.self){tag in
                        TagView(tag, Const.thirColor, "checkmark")
                            .matchedGeometryEffect(id: tag, in: animation)
                            .onTapGesture {
                                withAnimation(.bouncy){
                                    SelectedTags.removeAll(where: {$0 == tag})
                                }
                            }
                        
                    }
                }
                .padding(.horizontal,15)
                .frame(height: 30)
                .padding(.vertical,15)

            }
            .background(.gray.opacity(0.15))
            .border(.gray)

            .overlay {
                if SelectedTags.isEmpty{
                    Text("Şeçilen Kategoriler")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    
                }
            }
            .background(.white)
            .zIndex(1)
            VStack{
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
                .frame(minHeight: CGFloat((Const.categoryTags.count / 3)) * 35)

            }
            
            .scrollIndicators(.hidden)
            .background(.black.opacity(0.07))
            .zIndex(0)
        }
    }
}
