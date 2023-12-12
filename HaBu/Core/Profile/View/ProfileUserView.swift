//
//  NewProfileVİewStyle.swift
//  HaBu
//
//  Created by OmerErbalta on 26.11.2023.
//

import SwiftUI

struct ProfileUserView: View {
    @EnvironmentObject var navigate : NavigationStateManager

    @Binding var isShowingSideMenu:Bool
    let topEdge:CGFloat
    let maxHeight = UIScreen.main.bounds.height / 2.5
    var user:User
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var TollBarOffset : CGFloat = 0
    
    var body: some View {
        GeometryReader{proxy in
            let bottomEdge = proxy.safeAreaInsets.bottom
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing:15){
                    GeometryReader{proxy in
                        Tabbar(user:user, topEdge: topEdge,offset: $TollBarOffset,maxHeight:maxHeight)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: getHeaderHeight(),alignment:.bottom)
                        .overlay(
                            HStack(spacing:10){
                                HStack {
                                    Image("profil1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 20,height: 20)
                                    .clipShape(.circle)
                                    Text(user.username)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)
                                }
                                .opacity(topBarTitleOpacity())
                               
                                Spacer()
                                Button(action: {
                                    isShowingSideMenu = true
                                    
                                }, label: {
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
                        .background(
                            Const.thirColor,
                            in:CustomCorner(corners: [.bottomRight,.bottomLeft], radius: getCornerRadius())
                        
                        )
                        


                    }
                  
                    .frame(height: maxHeight)
                    .offset(y:-TollBarOffset)
                    .zIndex(2)
                    VStack(spacing:15){
                        ForEach(Post.MockData){post in
                            FeedViewCell(data:.init(post: post, user: user))
                        }
                    }
                    .zIndex(1)
                    
                }
                .modifier(OffsetModifier(offset: $TollBarOffset))
              
                
                //BottomBar
                .overlay(
                    GeometryReader{proxy -> Color in
                        let minY = proxy.frame(in:.global).minY
                        DispatchQueue.main.async {
                           
                            self.offset = minY
                        }
                        return Color.clear
                        
                    }
                    
                )
              
                .padding(.bottom,15 + bottomEdge + 35)
               


            }
           

        }
        .coordinateSpace(name:"SCROLL")
        .ignoresSafeArea(.all)
      
       
    }
    func getHeaderHeight() -> CGFloat{
      
        let topHeight = maxHeight + TollBarOffset
        return topHeight > (80 + topEdge) ? topHeight - 40 : (40 + topEdge)
    }
    func getCornerRadius()-> CGFloat{
        let progress = -TollBarOffset / (maxHeight - (40 + topEdge))
        let value =  1 - progress
        let radius = value * 40
        return TollBarOffset < 0 ? radius : 25
    }
    func topBarTitleOpacity()-> CGFloat{
        let progress = -(TollBarOffset) / ((maxHeight-40) - (40 + topEdge))
        return progress
        
        
    }
}
#Preview {
   ContentView()
}

struct Tabbar:View {
    @State var editButtonPosition = CGPoint(x:Const.width, y:0)
    let user:User
    var images = [
        "profil1",
        "profil2",
        "profil3"
    ]
    @State var imageCount = 0
    var topEdge: CGFloat
    @Binding var offset:CGFloat
    var maxHeight:CGFloat
    var body: some View {
        VStack{
            Spacer()
            HStack{
                //Image and picker
                VStack {
                    CircleProfileImage(userIamgeUrl:images[imageCount], size: .xlage)
                    .padding(.leading,10)
                    .gesture(DragGesture().onEnded({ value in
                        if value.translation.width < 1 {
                            withAnimation{
                                if imageCount < images.count - 1{
                                    imageCount += 1
                                }
                                else{
                                    imageCount = 0
                                }
                            }
                        }
                        else{
                            withAnimation{
                                if imageCount > 0{
                                    imageCount -= 1
                                }
                                else{
                                    imageCount = images.count - 1
                                }
                            }
                        }
                }))
                    HStack{
                        ForEach(0..<images.count) { index in
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(index == self.imageCount ? .white : .black)
                        }
                    }
                }
                VStack(alignment:.leading){
                    Text("\(user.name) \(user.surName)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Bilgisayar Mühendisliği")
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("145").font(.subheadline)
                    }//Rating
                }
                Spacer()
                //User Info
                VStack{
                    Spacer()
                    Text("4")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    Text("Post")
                        .foregroundStyle(.white)
                        .font(.footnote.bold())
                    Spacer()
                    
                }
            }
            .padding(.top,maxHeight * 0.25)
            //Ömer update
 /*           SlidableButton(destination: AnyView(EditProfileView(data: .init(user: User.MockData[0]))), position:editButtonPosition, dragDirection: .left, text: "Edit", color: .white, textColor: .black)
*/        }
        .padding()
        .opacity(getOpacity())
    }
    
    func getOpacity()->CGFloat{
        let progress = -offset / 12
        let opacity = 1 - progress
        return offset > 0 ? 1 : opacity
    }
}
