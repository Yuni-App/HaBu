//
//  ScrollableTabView.swift
//  HaBu
//
//  Created by OmerErbalta on 27.11.2023.
//

import SwiftUI
import Kingfisher

#Preview {
    ProfileView(user: User.MockData[0])
}

struct SlidableImagesView: View {
    var item : [KFImage]
    @Binding var index : Int
    var size : CGFloat
    var rect : CGRect
    var proggress : CGFloat
    var resizedOffsetY: CGFloat
    @State private var dragDirection: DragDirection = .left
    var body: some View {
        VStack{
          
            if item.count != 0{
                VStack{
                    item[index]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: rect.width-50,height: rect.height-50)
                        .clipShape(.circle)
                        .padding()
                        .scaleEffect(1 - (proggress * 0.55),anchor: .topLeading)
                        .offset(x : -(rect.minX-10) * proggress,y: -(resizedOffsetY * proggress)+Const.height * 0.07)
                        .gesture(DragGesture().onChanged({ value in
                            dragDirection = value.translation.width > 1 ? .left : .right
                        }).onEnded({ value in
                            withAnimation(.smooth){
                                if dragDirection == .right{
                                    if self.index < item.count - 1 {
                                        self.index += 1
                                    }
                                    
                                }
                                else if dragDirection == .left{
                                    if self.index > 0{
                                        self.index  -= 1
                                    }
                                    
                                }
                            }
                        }))
                    
                    HStack {
                        ForEach(item.indices ,id:\.self){ i in
                            
                            Circle()
                                .frame(width: 7,height: 7)
                                .foregroundStyle(i == index ? .black : .white)
                        }
                    }
                    .offset(x : -(rect.minX-10) * proggress,y: -(resizedOffsetY * proggress)+Const.height * 0.05)
                    .scaleEffect(1 - (proggress), anchor: .center)
                    
                    
                }
            }
            else{
                Image.iconManager(.person, size: size, weight: .thin, color: .white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: rect.width-50,height: rect.height-50)
                    .clipShape(.circle)
                    .padding()
                    .scaleEffect(1 - (proggress * 0.55),anchor: .topLeading)
                    .offset(x : -(rect.minX-10) * proggress,y: -(resizedOffsetY * proggress)+Const.height * 0.07)
            }
        }
      
    }
}
