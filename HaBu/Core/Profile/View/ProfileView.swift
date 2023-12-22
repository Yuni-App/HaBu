//
//  ProfileView.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI


struct ProfileView : View {
    @Environment(\.dismiss) var dissmis
    @StateObject var profileVM :ProfileViewModel
    init(hideTab:Binding<Bool>,user:User) {
        _hideTab = hideTab
        self.user = user
        self._profileVM = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    init(user:User) {
        self.user = user
        _hideTab = .constant(false)
        activateBackButton = true
        self._profileVM = StateObject(wrappedValue: ProfileViewModel(user: user))
        
    }
    var activateBackButton = false
    let user : User
    @Binding var hideTab:Bool
    
    var body: some View{
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            ProfileGeometry(size:size,safeArea:safeArea,user: user)
        }
        .ignoresSafeArea(.all,edges: .top)
        
        /*   ZStack {
         ScrollView(.vertical,showsIndicators: false){
         VStack(spacing:15){
         /*Tabbar(user:profileVM.user, topEdge: profileVM.topEdge,offset: $profileVM.TollBarOffset,maxHeight:profileVM.maxHeight)
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity)
          .frame(height: getHeaderHeight(),alignment:.bottom)
          .background(
          Const.thirColor,
          in:CustomCorner(corners: [.bottomRight,.bottomLeft], radius: getCornerRadius())
          
          )*/
         Rectangle()
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
         .frame(width: 40,height: 40)
         .clipShape(.circle)
         Text(user.username)
         .fontWeight(.bold)
         .font(.headline)
         .foregroundStyle(.primary)
         }
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
         .padding(.top,profileVM.topEdge + 25)
         ,alignment: .top
         
         )
         
         .frame(height: profileVM.maxHeight)
         .offset(y:-profileVM.TollBarOffset)
         
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
         print(minY)
         if minY < profileVM.offset{
         if profileVM.offset < 0 && -minY > (profileVM.lastOffset + durationOffset){
         withAnimation(.easeOut .speed(1.2)){
         hideTab = true
         
         }
         profileVM.lastOffset = -profileVM.offset
         }
         
         }
         if minY > profileVM.offset && -minY < (profileVM.lastOffset - durationOffset){
         withAnimation(.easeOut .speed(1.5)){
         hideTab = false
         
         }
         profileVM.lastOffset = -profileVM.offset
         
         }
         
         }
         return Color.clear
         }
         .coordinateSpace(name:"SCROLL")
         
         
         )
         .padding(.bottom,15 + 35)
         
         
         }
         
         
         
         
         
         .ignoresSafeArea(.all,edges: .all)
         
         
         
         }*/
    }
    func getHeaderHeight() -> CGFloat{
        let topHeight = profileVM.maxHeight + profileVM.TollBarOffset
        return topHeight > (80 + profileVM.topEdge) ? topHeight : (80 + profileVM.topEdge)
    }
    func getCornerRadius()-> CGFloat{
        let progress = -profileVM.TollBarOffset / (profileVM.maxHeight - (40 + profileVM.topEdge))
        let value =  1 - progress
        let radius = value * 40
        return profileVM.TollBarOffset < 0 ? radius : 25
    }
    func topBarTitleOpacity()-> CGFloat{
        let progress = -(profileVM.TollBarOffset) / ((profileVM.maxHeight-40) - (80 + profileVM.topEdge))
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
struct ProfileGeometry: View {
    var size : CGSize
    var safeArea : EdgeInsets
    var user:User
    
    @State private var offsetY:CGFloat = 0
    var body: some View {
        ScrollViewReader{ scrollProxy in
            ScrollView{
                VStack(spacing:0){
                    HeaderView()
                        .zIndex(1)
                   /* Rectangle()
                        .fill(Const.thirColor)
                        .frame(height: 150)
                        .overlay(
                            VStack{
                                HStack {
                                    VStack(alignment:.leading) {
                                        Text("\(user.name) \(user.surName)")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        
                                        Text(user.bio ?? "")
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("Post")
                                        Text("14")
                                    }
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    
                                }
                                .foregroundStyle(.white)
                                Spacer()
                            }
                                .padding()
                        )*/
                    ForEach(Post.MockData){post in
                        FeedViewCell(post: post, user: User.MockData[0])
                        
                    }
                }
                .id("SCROLLVIEW")
                .background(
                    ScrollDetector{offset in
                        offsetY = -offset
                        
                    } onDraggingEnd: {offset, velocity  in
                        let headerHeight = (size.height * 0.5) + safeArea.top
                        let minimumHeaderHeight = 100 + safeArea.top
                        
                        let targetEnd  = offset + (velocity * 45)
                        if targetEnd < (headerHeight - minimumHeaderHeight) && targetEnd > 0{
                            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)){
                                scrollProxy.scrollTo("SCROLLVIEW",anchor:  .top)
                            }
                        }
                    }
                    
                )
            }
            
        }
    }
    @ViewBuilder
    func HeaderView()->some View{
        @Environment(\.dismiss) var dissmis
        let headerHeight = (size.height * 0.4) + safeArea.top
        let minimumHeaderHeight = 100 + safeArea.top
        let proggress = max( min(-offsetY  / (headerHeight - minimumHeaderHeight), 1), 0)
        GeometryReader{_ in
            ZStack{
                Rectangle()
                    .fill(Const.thirColor.gradient)
                
                
                VStack(spacing: 15){
                    GeometryReader{
                        let rect = $0.frame(in: .global)
                        let halfScaledHeight = (rect.height * 0.3) * 0.5
                        let midY = rect.midY
                        let bottomPadding : CGFloat = 15
                        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
                        
                        //Buttons
                        HStack{
                            Buttons.backButton( action: {
                                dissmis()
                            }, color: .white)
                            .offset(x : -(rect.minX) * proggress,y: -resizedOffsetY * (proggress * 1.7) )
                            .padding()
                            
                            Spacer()
                            Button(action: {
                                
                            }, label: {
                                Image.iconManager(.settings, size: 20, weight: .bold, color: .white)
                            })
                            .offset(x : -(rect.minX) * proggress,y: -resizedOffsetY * (proggress * 1.7) )
                            
                            .padding()
                        }
                        
                        //User name/surname rating
                        HStack{
                            VStack(alignment:.leading) {
                                Text(user.name)
                                Text(user.surName)
                            }
                            
                            Spacer()
                           
                            .padding(.horizontal)
                            VStack {
                                Text("Post")
                                Text("15")
                            }
                        }.foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.semibold)
                        .opacity(proggress == 0 ? 1:0)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding(.top,Const.height * 0.1)
                        .padding()
                        Image("profil3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: rect.width-70,height: rect.height-70)
                            .clipShape(.circle)
                            .padding()
                            .scaleEffect(1 - (proggress * 0.55),anchor: .topLeading)
                            .offset(x : -(rect.minX-10) * proggress,y: -(resizedOffsetY * proggress)+Const.height * 0.08)

                    }
                    .frame(width: Const.width,height: headerHeight * 0.5)
                    
                    // userName and rating
                    HStack {
                        Text(user.username)
                            .font(.title2)
                            .fontWeight(.bold)
                            .scaleEffect(1-(proggress * 0.1))
                            .padding(.horizontal)
                            VStack{
                                Image.iconManager(.star, size: 15, weight: .bold, color: .yellow)
                                    .scaleEffect(1-(proggress * 0.25))

                                Text("\(user.rating.formatted())")
                                    .scaleEffect(1-(proggress * 0.15))

                            }
                            .fontWeight(.bold)

                        
                        }
                            .offset(y:((Const.height * 0.18) * proggress) - Const.height * 0.19)
                            
                        .foregroundStyle(.white)
                    
                    
                    
                }
                .padding(.top,safeArea.top)
                
            }
            .frame(width: Const.width, height:(headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY),alignment:.bottom)
            .offset(y:-offsetY)
        }.frame(height: headerHeight)
    }
}


struct ScrollDetector:UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    
    var onScroll:(CGFloat) -> ()
    var onDraggingEnd:(CGFloat,CGFloat) ->()
    
    func makeUIView(context: Context) ->  UIView {
        return UIView()
    }
    func  updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isDelegatedAdded {
                scrollView.delegate = context.coordinator
                context.coordinator.isDelegatedAdded = true
            }
        }
    }
    class Coordinator:NSObject,UIScrollViewDelegate{
        var parent : ScrollDetector
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        var isDelegatedAdded : Bool = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y,velocity.y)
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.panGestureRecognizer.view)
            parent.onDraggingEnd(scrollView.contentOffset.y,velocity.y)
            
        }
    }
}
