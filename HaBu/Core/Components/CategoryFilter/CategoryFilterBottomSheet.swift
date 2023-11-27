//
//  CategoryFilterBottomSheet.swift
//  HaBu
//
//  Created by OmerErbalta on 25.11.2023.
//

import SwiftUI

struct CategoryFilterBottomSheet: View {
@State var SelectedTags:[String] = []
@Namespace private var animation
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 10){
                    ForEach(SelectedTags ,id: \.self){tag in
                        TagView(tag, .pink, "checkmark")
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
                        TagView(tag, .blue, "plus")
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
            .scrollIndicators(.hidden)
            .background(.black.opacity(0.07))
            .zIndex(0)
            ZStack{
                Button(action: {}, label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding(.vertical,15)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 12)
                            .fill(.pink.gradient)
                        )
                    
                })
                .disabled(SelectedTags.count < 3)
                .opacity(SelectedTags.count < 3 ? 0.5 : 1)
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
    .frame(height: 35)
    .foregroundStyle(.white)
    .padding(.horizontal,15)
    .background(
        Capsule().fill(color.gradient)
    )
}
