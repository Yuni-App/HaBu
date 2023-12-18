//
//  ProfileView.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI


struct ProfileView : View {
    
    init(hideTab:Binding<Bool>,user:User) {
        _hideTab = hideTab
        self.user = user
    }
    init(user:User) {
        self.user = user
        _hideTab = .constant(false)
        activateBackButton = true
        
        
    }
    
    @Environment(\.dismiss) var dissmis
    var activateBackButton = false
    let user : User
    @Binding var hideTab:Bool
    @State var editButtonPosition = CGPoint(x:Const.width, y : Const.height / 5)
    @State private var shouldNavigate = false
    @State var offset:CGFloat = 0
    @State var lastOffset:CGFloat = 0
    @State var TollBarOffset : CGFloat = 0
    @State var topEdge:CGFloat = Const.height * 0.03
    let maxHeight = UIScreen.main.bounds.height / 2.7
    @State var imageCount = 0
    var body: some View{
        ZStack {
                GeometryReader{proxy in
                    let bottomEdge = proxy.safeAreaInsets.bottom
                    ScrollView(.vertical,showsIndicators: false){
                        VStack(spacing:15){
                            GeometryReader{proxy in
                                Tabbar(user:user, topEdge: topEdge,offset: $TollBarOffset,maxHeight:maxHeight)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: getHeaderHeight(),alignment:.bottom)
                                .background(
                                    Const.thirColor,
                                    in:CustomCorner(corners: [.bottomRight,.bottomLeft], radius: getCornerRadius())
                                
                                )
                                .overlay(
                                    
                                    HStack(spacing:10){
                                        if activateBackButton == true{
                                            Buttons.backButton(action: {
                                                dissmis()

                                            }, color: .white)
                                            Spacer()
                                        }
                                        HStack {
                                            Image("profil1")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 30,height: 30)
                                            .clipShape(.circle)
                                            Text(user.username)
                                                .fontWeight(.bold)
                                                .foregroundStyle(.primary)
                                        }
                                        .padding(.top,40)
                                        .opacity(topBarTitleOpacity())
                                       
                                        Spacer()
                                        NavigationLink {
                                            SettingsView()
                                        } label: {
                                            Image.iconManager(.settings, size: 20, weight: .black, color: .white)
                                        }

                                      
                                    }
                                        .padding(.horizontal,10)
                                        .frame(height:40)
                                        .foregroundStyle(.white)
                                        .padding(.top,topEdge)
                                    ,alignment: .top
                                    
                                )
                            }
                            .frame(height: maxHeight)
                            .offset(y:-TollBarOffset)
                            .zIndex(1)
                            VStack(spacing:15){
                                   
                                ForEach(Post.MockData){post in
                                    FeedViewCell(post: post, user: User.MockData[0])
                                }
                            }
                            .zIndex(0)
                            
                        }
                        .overlay(
                            GeometryReader{proxy -> Color in
                                let minY = proxy.frame(in: .named("SCROLL")).minY
                                let durationOffset: CGFloat = 35
                                DispatchQueue.main.async {
                                    if minY < offset{
                                        if offset < 0 && -minY > (lastOffset + durationOffset){
                                            withAnimation(.easeOut .speed(1.2)){
                                                print(minY)
                                                hideTab = true
                                            }
                                            lastOffset = -offset
                                        }
                                        
                                    }
                                    if minY > offset && -minY < (lastOffset - durationOffset){
                                        withAnimation(.easeOut .speed(1.5)){
                                            hideTab = false
                                        }
                                        lastOffset = -offset
                                        
                                    }
                                    self.offset = minY
                                }
                                return Color.clear
                                
                            }
                            
                        )
                        .padding(.bottom,15 + bottomEdge + 35)
                        
                        .modifier(OffsetModifier(offset: $TollBarOffset))
                    }
                  
                }
                .ignoresSafeArea(.all)
        }
       
    }
    func getHeaderHeight() -> CGFloat{
        let topHeight = maxHeight + TollBarOffset
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    func getCornerRadius()-> CGFloat{
        let progress = -TollBarOffset / (maxHeight - (40 + topEdge))
        let value =  1 - progress
        let radius = value * 40
        return TollBarOffset < 0 ? radius : 25
    }
    func topBarTitleOpacity()-> CGFloat{
        let progress = -(TollBarOffset) / ((maxHeight-40) - (80 + topEdge))
        return progress
        
        
    }
}

#Preview {
    ProfileView(hideTab: .constant(true), user: User.MockData[0])
}
struct Tabbar:View {
    @State var editButtonPosition = CGPoint(x:Const.width, y:0)
    let user:User
    let images = [
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

                    Text(user.department)

                    HStack {
                        Image.iconManager(.star, size: 15, weight: .bold, color: .white)
                            .foregroundStyle(.yellow)
                        Text("\(user.rating, specifier: "%0.f")").font(.subheadline)
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
           
            Buttons.SlidableButton(destination:AnyView(EditProfileView(user: User.MockData[0])), position: editButtonPosition, dragDirection: .left, text: user == User.MockData[0] ?  "Edit" : "Mesaj", color: .white, textColor: .black)
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
