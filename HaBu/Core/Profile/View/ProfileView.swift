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
    
    init(hideTab:Binding<Bool>) {
        _hideTab = hideTab
        self.user = AuthService.shared.currentUser!
        self._profileVM = StateObject(wrappedValue: ProfileViewModel(user:AuthService.shared.currentUser!))
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
        GeometryReader{ proxy in
            let size = proxy.size
            let safeArea = proxy.safeAreaInsets
            ProfileGeometry(action: {dissmis()}, activateBackButton:activateBackButton, hideTab: $hideTab, size:size,safeArea:safeArea,profileVM:profileVM, user: user)
            
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all,edges: .top)
    }
}

#Preview {
    ProfileView(user: User.MockData[0])
}
struct ProfileGeometry: View {
    @Environment(\.dismiss) var dismiss
    var action:()->Void
    @State var navigate = false
    @State var navigationPage : AnyView? = nil
    var activateBackButton:Bool
    @Binding var hideTab:Bool
    var size : CGSize
    var safeArea : EdgeInsets
    var profileVM:ProfileViewModel
    var user:User
    @State var imageIndex = 0
    @State private var offsetY:CGFloat = 0
    var body: some View {
        ScrollViewReader{ scrollProxy in
            let headerHeight = (size.height * 0.4) + safeArea.top
            let minimumHeaderHeight = Const.height * 0.1 + safeArea.top
            let proggress = max( min(-offsetY  / (headerHeight - minimumHeaderHeight), 1), 0)
            ScrollView{
                VStack(spacing:0){
                    GeometryReader{_ in
                        ZStack{
                            Rectangle()
                                .fill(Const.primaryColor.gradient)
                            VStack(spacing: 15){
                                GeometryReader{
                                    let rect = $0.frame(in: .global)
                                    let halfScaledHeight = (rect.height * 0.3) * 0.5
                                    let midY = rect.midY
                                    let bottomPadding : CGFloat = 15
                                    let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
                                    //Buttons
                                    HStack{
                                        if activateBackButton{
                                            Buttons.backButton(action: {
                                                dismiss()
                                            }, color: .white)
                                            .padding()
                                        }
                                        Spacer()
                                        Button(action: {
                                            navigate = true
                                            navigationPage = AnyView(SettingsView())
                                            
                                        }, label: {
                                            Image.iconManager(.settings, size: 20, weight: .bold, color: .white)
                                        })
                                        .padding()
                                        
                                    } .offset(x : -(rect.minX) * (proggress ),y: -resizedOffsetY * (proggress * 1.7) )
                                    
                                    // rating and post count
                                    HStack{
                                        VStack(alignment:.center) {
                                            Image.iconManager(.star, size: 30, weight: .bold, color: .yellow)
                                            Text("90")
                                        }
                                        .scaleEffect(1 - (proggress * 0.45),anchor: .topLeading)
                                        .offset(x : -(rect.minX-Const.width * 0.65 ) * proggress,y: -(resizedOffsetY * (proggress * 0.75)))
                                        
                                        Spacer()
                                            .padding(.horizontal)
                                        VStack {
                                            Text("Post")
                                            Text("15")
                                        }
                                        .opacity(proggress == 0 ? 1:0)
                                        
                                    }.foregroundStyle(.white)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .fontWeight(.semibold)
                                        .padding(.top,Const.height * 0.1)
                                        .padding()
                                    
                                    // user name and surname / depertment
                                    HStack{
                                        Spacer()
                                        VStack (alignment:.center){
                                            Text("\(user.name) \(user.surname)")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.white)
                                            Text(user.department)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.black)
                                        }
                                        Spacer()
                                    }
                                    .opacity(proggress == 0 ? 1:0)
                                    .foregroundStyle(.black)
                                    .padding(.top,Const.height * 0.25)
                                    
                                    
                                    HStack{
                                        Buttons.SlidableButton(action: {
                                            navigate = true
                                            navigationPage = AnyView(EditProfileView(user: user))
                                        },position:profileVM.editButtonPosition , dragDirection: .left, text: activateBackButton ? "Mesaj" : "Edit", color: .white, textColor: .black)
                                    }
                                    .padding(.top,Const.height * 0.05)
                                    .offset(x : 500 * proggress)
                                    SlidableImagesView(item:profileVM.images ?? [], index: $imageIndex, size: 100 , rect :rect, proggress:proggress,resizedOffsetY:resizedOffsetY)
                                    
                                }
                                .frame(width: Const.width,height: headerHeight * 0.5)
                                // userName
                                HStack {
                                    Text(user.username)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .scaleEffect(1-(proggress * 0.15))
                                        .padding(.horizontal)
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
                        .zIndex(1)
                    Rectangle()
                        .fill(Const.primaryColor)
                        .frame(height: user.bio?.count ?? 0 > 5 ? Const.height * 0.1 : 0)
                        .overlay (
                            Text(user.bio ?? "")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.horizontal,5)
                                .padding(.top,10)
                            ,alignment: .topLeading
                        )
                   
                    if let posts = profileVM.posts{
                        if posts.isEmpty{
                            
                            Text("Bu Kullanıcının Hiçbir Postu Bulunamadı")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(height: Const.height * 0.6)
                                .foregroundStyle(Const.primaryColor)
                        }
                        else{
                            ForEach(profileVM.posts!){post in
                                FeedViewCell(post: .constant(post) , user: user, likeAction: .liked)
                        }
                    }
                    
                }
                    else{
                        HStack {
                            ProgressView()
                                .tint(Const.primaryColor)
                                .frame(width: 30,height: 30)
                                .fontWeight(.bold)
                            .padding()
                            Text("Yükleniyor..")
                                .fontWeight(.bold)
                                .foregroundStyle(Const.primaryColor)
                        }

                    }
                        
                    
                   
                }
                .id("SCROLLVIEW")
                .background(
                    ScrollDetector{offset in
                        offsetY = -offset
                        
                        if offsetY < offset {
                            print(offsetY)
                        }
                        
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
            .navigationDestination(isPresented: $navigate) {
                navigationPage
            }
            
            
        }
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
