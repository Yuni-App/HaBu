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
    @State var selectedFilterIndex = 0
    @Namespace private var animation
    var body: some View {
        VStack {
            ScrollView(.horizontal,showsIndicators: false){
                GeometryReader {geometry in
                    HStack {
                        ForEach(Const.anonimFilters,id: \.id){filter in
                            cardView(filter.title, filter.subTitle ,filter.color, filter.icon)
                        }

                    }
                }
                
            }.content.offset(x: self.scrollOffset)
            .frame(height: Const.height * 0.1)
            .gesture(DragGesture().onChanged({ value in
                dragDirection = value.translation.width > 1 ? .left : .right
            })
                .onEnded({ value in
                    withAnimation(.smooth){
                    if dragDirection == .right{
                        if self.selectedFilterIndex < 2 {
                            self.selectedFilterIndex += 1
                            self.scrollOffset -= Const.width
                        }
                        else{
                            selectedFilterIndex = 0
                            self.scrollOffset = 0
                        }
                       
                    }
                        else if dragDirection == .left{
                        if self.selectedFilterIndex > 0{
                            self.scrollOffset += Const.width
                            self.selectedFilterIndex -= 1
                        }
                       
                    }
                }
                    print(self.selectedFilterIndex)

                    
                })
            )
            .padding(.top,10)
            .overlay {
                HStack{
                    Button(action: {
                        withAnimation(.snappy){
                            if self.selectedFilterIndex > 0{
                                self.scrollOffset += Const.width
                                self.selectedFilterIndex -= 1
                            }
                            else{
                                self.scrollOffset = -(2 * Const.width)
                                self.selectedFilterIndex = 2
                            }
                        }
                        
                    }, label: {
                        Image.iconManager(.back, size: 20, weight: .bold, color: .black)
                            .padding(5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.black, lineWidth: 1)
                            }
                    })
                    .padding(5)
                    Spacer()
                    Button(action: {
                        withAnimation(.snappy){
                            if self.selectedFilterIndex < 2 {
                                self.selectedFilterIndex += 1
                                self.scrollOffset -= Const.width
                            }
                            else{
                                selectedFilterIndex = 0
                                self.scrollOffset = 0
                            }
                        }
                        
                    }, label: {
                        Image.iconManager(.next, size: 20, weight: .bold, color: .black)
                            .padding(5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.black, lineWidth: 1)
                            }
                    })
                    .padding(5)
                    
                }
            }
            Divider().frame(height: 1)
                .background(.black)
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
                .padding(10)
            }
            .frame(height:CGFloat(Const.categoryTags.count) * 20)
            .scrollIndicators(.hidden)
            .background(.black.opacity(0.07))
            .zIndex(0)
            ZStack{
                Button(action: {
                    
                }, label: {
                    Text("Filtrele")
                        .fontWeight(.semibold)
                        .padding(.vertical,15)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .fill(Const.thirColor.gradient)
                        )
                    
                })
                .disabled(SelectedTags.count < 1 && selectedFilterIndex == 0)
                .opacity(SelectedTags.count < 1 && selectedFilterIndex == 0 ? 0.5 : 1)
                .padding()
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
    .frame(height: 25)
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

