//
//  NewProfileVİewStyle.swift
//  HaBu
//
//  Created by OmerErbalta on 26.11.2023.
//

import SwiftUI

struct ProfileUserView: View {
    @Binding var isShowingSideMenu:Bool
    let topEdge:CGFloat
    let maxHeight = UIScreen.main.bounds.height / 2.7
    var user:User
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:15){
                GeometryReader{proxy in
                    Tabbar(user:user, topEdge: topEdge,offset: $offset,maxHeight:maxHeight)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(),alignment:.bottom)
                    .background(
                        Const.thirColor,
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
                }
                .frame(height: maxHeight)
                .offset(y:-offset)
                .zIndex(2)
                VStack(spacing:15){
                    ForEach(Post.MockData){post in
                        FeedViewCell(post: post, user: user)
                    }
                }
                .zIndex(1)
                
            }
            .modifier(OffsetModifier(offset: $offset))
        }
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
        return offset < 0 ? radius : 25
    }
    func topBarTitleOpacity()-> CGFloat{
        let progress = -(offset) / ((maxHeight-40) - (40 + topEdge))
        return progress
        
        
    }
}
#Preview {
    ProfileUserView(isShowingSideMenu: .constant(false), topEdge: 50, user: User.MockData[0])
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
            SlidableButton(destination: AnyView(EditProfileView(user: User.MockData[0])), position:editButtonPosition, dragDirection: .left, text: "Edit", color: .white, textColor: .black)
        }
        .padding()
        .opacity(getOpacity())
    }
    
    func getOpacity()->CGFloat{
        let progress = -offset / 70
        let opacity = 1 - progress
        return offset > 0 ? 1 : opacity
    }
}
