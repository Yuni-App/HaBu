//
//  NewProfileVİewStyle.swift
//  HaBu
//
//  Created by OmerErbalta on 26.11.2023.
//

import SwiftUI

struct NewProfileViewStyle: View {
    let topEdge:CGFloat
    let maxHeight = UIScreen.main.bounds.height / 2.4
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:15){
                GeometryReader{proxy in
                    Tabbar(topEdge: topEdge,offset: $offset,maxHeight:maxHeight)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(),alignment:.bottom)
                    .background(
                        .blue,
                        in:CustomCorner(corners: [.bottomRight,.bottomLeft], radius: getCornerRadius())
                    
                    )
                    .overlay(
                        HStack(spacing:10){
                            HStack {
                                Image("profil1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 20,height: 20)
                                .clipShape(.circle)
                                Text("Ömer  Erbalta")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }
                            .opacity(topBarTitleOpacity())
                           
                            Spacer()
                            Button(action: {}, label: {
                                Image(systemName: "line.3.horizontal.decrease")
                                    .font(.body.bold())
                            })
                          
                        }
                            .padding(.horizontal,10)
                            .frame(height:40)
                            .foregroundStyle(.white)
                            .padding(.top,topEdge)
                        ,alignment: .top
                        
                    )
                }
                .frame(height: maxHeight)
                .offset(y:-offset)
                .zIndex(2)
                VStack(spacing:15){
                    //PostView
                    ForEach(0..<20){_ in
                            Text("deneme")
                    }
                }
                .zIndex(1)
                
            }
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.all)
    }
    func getHeaderHeight() -> CGFloat{
        let topHeight = maxHeight + offset
        return topHeight > (80 + topEdge) ? topHeight - 40 : (40 + topEdge)
    }
    func getCornerRadius()-> CGFloat{
        let progress = -offset / (maxHeight - (40 + topEdge))
        let value =  1 - progress
        let radius = value * 40
        
        return offset < 0 ? radius : 40
    }
    func topBarTitleOpacity()-> CGFloat{
        let progress = -(offset) / (maxHeight - (80 + topEdge))
        return progress
        
        
    }
}
#Preview {
    NewProfileViewStyle(topEdge: 50)
}

struct Tabbar:View {
    var topEdge: CGFloat
    @Binding var offset:CGFloat
    var maxHeight:CGFloat
    var body: some View {
        VStack(alignment: .leading,spacing:15){
            Image("profil1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80,height:80)
                .clipShape(.rect(cornerRadius: 10))
            Text("Ömer Erbalta")
                .font(.title.bold())
            Text("asdasdasdas adsaasdadas dadsadsdas asdasadasd")
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding()
        
        .padding(.bottom)
        .opacity(getOpacity())
    }
    
    func getOpacity()->CGFloat{
        let progress = -offset / 70
        let opacity = 1 - progress
        return offset > 0 ? 1 : opacity
    }
}
