//
//  ScrollableTabView.swift
//  HaBu
//
//  Created by OmerErbalta on 27.11.2023.
//

import SwiftUI

struct ScrollableTabView: View {
    @State private var selectedTab : Tab?
    @Environment (\.colorScheme) private var  sheme
    @State private var dragDirection: DragDirection = .left
    @State private var tabProgress :CGFloat =  0
    var body: some View {
        VStack(spacing:15){
            HStack{
                Button(action: {
                    
                }, label: {
                    Image.iconManager(.key, size: 20, weight: .bold, color: .black)
                    Spacer()
                    Image.iconManager(.key, size: 20, weight: .bold, color: .black)

                })
            }
            
            CustomTabbar()
            
            ScrollView(.horizontal){
                HStack {
                    postScrollView()
                    postScrollView()
                } .gesture(DragGesture().onChanged({ value in
                    
                    self.dragDirection = value.translation.width > 1 ? .left : .right
                    print(dragDirection)

                })
                    .onEnded({ _ in
                        withAnimation(.snappy){
                            if dragDirection == .left{
                                self.tabProgress = 0
                                self.selectedTab = .Posts
                                print(tabProgress)
                            }
                            else if dragDirection == .right{
                                tabProgress = 1
                                selectedTab = .Saves
                                print(tabProgress)
                            }
                        }
                        
                    })
                
                )
                
               
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
        .background(.gray.opacity(0.1))
    }
    @ViewBuilder 
    func CustomTabbar()-> some View{
        HStack {
            ForEach(Tab.allCases, id:\.rawValue){tab in
                HStack {
                    Image.iconManager(tab.icon, size: 20, weight: .bold, color:.black)
                    Text(tab.rawValue)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy){
                        selectedTab = tab
                    }
                }
                
            }
        }.background{
            GeometryReader{
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(Tab.allCases.count )
                Capsule()
                    .fill(sheme == .dark ? .black : .white)
                    .frame(width:capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
                
            }
        }
        .background(.gray.opacity(0.1),in: .capsule)
            .padding(.horizontal,15)
      
        

    }
}

#Preview {
    ScrollableTabView()
}

enum Tab:String,CaseIterable{
    case Posts
    case Saves
    var icon : AppIcon{
        switch self {
        case .Posts:
            return .mail
        case .Saves:
            return .pencil
        }
    }
}

struct postScrollView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack{
                ForEach(Post.MockData){post in
                    Rectangle().fill(.red)
                        .frame(width: Const.width * 0.9 ,height: 200)
                        .padding(.horizontal ,Const.width * 0.05)
                }
            }
        }
    }
}
