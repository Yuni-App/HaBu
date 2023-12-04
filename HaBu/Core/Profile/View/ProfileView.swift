//
//  ProfileView.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI


struct ProfileView : View {
    @State private var showMenu: Bool = false
    @State var editButtonPosition = CGPoint(x:Const.width, y : Const.height / 5)
    @State private var isShowingPopUp = false
    @State private var shouldNavigate = false
    @State private var selectedIndex = 0
    
    @Binding var hideTab:Bool
    @State var offset:CGFloat = 0
    @State var lastOffset:CGFloat = 0
    @State var messageBox = 20

    let user : User
    var images = [
        "profil1",
        "profil2",
        "profil3"
    ]
    @State var imageCount = 0
    @State var gridSelector = 0
    var gridOptions = [
        "Post",
        "Kaydedilenler"
    ]
    
    var body: some View{
        ZStack {
            GeometryReader{proxy in
                    let topEdge = proxy.safeAreaInsets.top
                ProfileUserView(isShowingSideMenu: $showMenu, hideTab: $hideTab, topEdge: topEdge, user: user)
            }
            GeometryReader { _ in
            HStack {
            Spacer()
            SideMenu(isShowingSideMenu: $showMenu)
            .offset(x: showMenu ? 0: UIScreen.main.bounds.width)
            .animation(.easeInOut(duration: 0.2), value: showMenu)
            }
            }.background(Color.gray.opacity(showMenu ? 0.3: 0))
            
            }
        }
        /*  var body: some View {
         NavigationStack {
         ZStack {
         VStack{
         ScrollView{
         HStack{
         Spacer()
         Button{
         self.showMenu.toggle()
         }label: {
         
         Image(systemName: "text.justify")
         .foregroundColor(.white)
         
         }.padding(.horizontal,20)
         
         }// settings action
         .frame(width:Const.width,height: 10)
         //User Info
         ZStack {
         VStack{
         ZStack {
         HStack{
         VStack {
         Button(action: {
         isShowingPopUp = true
         }, label: {
         CircleProfileImage(userIamgeUrl:images[imageCount] , size: .xlage)
         .padding(.leading,10)
         .fullScreenCover(isPresented: $isShowingPopUp, content: {
         ZStack {
         Const.thirColor
         .edgesIgnoringSafeArea(.all)
         
         VStack {
         Text("Detaylı Görüntü")
         .font(.title)
         .foregroundColor(.white)
         .padding()
         
         Image(images[imageCount])
         .resizable()
         .aspectRatio(contentMode: .fit)
         .frame(maxWidth: .infinity, maxHeight: 300)
         .padding()
         Button("Kapat") {
         // Pop-up kapatma
         isShowingPopUp = false
         }
         .padding()
         .foregroundColor(.black)
         }
         .background(Color.white)
         .cornerRadius(20)
         .padding()
         }
         })
         
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
         
         })
         
         HStack{
         ForEach(0..<images.count) { index in
         Circle()
         .frame(width: 5, height: 5)
         .foregroundColor(index == self.imageCount ? .white : .black)
         }
         } //Image selection radio
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
         VStack{
         Spacer()
         Text("4")
         .font(.title)
         .fontWeight(.semibold)
         .foregroundStyle(.white)
         Text("Post")
         .foregroundStyle(.white)
         .font(.footnote)
         .fontWeight(.semibold)
         Spacer()
         
         } //Post Count
         .padding(.horizontal,30)
         
         
         } //User Info
         
         SlidableButton(destination: AnyView(EditProfileView(user: User.MockData[0])), position:editButtonPosition, dragDirection: .left, text: "Edit", color: .white, textColor: .black)
         
         }
         }.frame(width: Const.width,height: Const.height * 0.25)
         
         }
         //postGrid
         VStack{
         HStack{
         HStack{
         ForEach(0..<gridOptions.count) { i in
         CategoryView(isActive: i==selectedIndex, text: gridOptions[i])
         .onTapGesture {
         selectedIndex = i
         }
         
         }.padding()
         }
         }
         Divider()
         .background(.black)
         .frame(height:1)
         
         ForEach(Post.MockData,id:\.id){post in
         FeedViewCell(post: post, user: User.MockData[0])
         .font(.title)
         .padding(.top,20)
         Divider()
         }
         }
         .frame(width: Const.width)
         .background(.white)
         .clipShape(
         .rect(
         topLeadingRadius:40 ,
         bottomLeadingRadius: 0,
         bottomTrailingRadius: 0,
         topTrailingRadius:40
         )
         )
         
         }
         .background(Const.primaryColor)
         }
         GeometryReader { _ in
         HStack {
         Spacer()
         SideMenu(isShowingSideMenu: $showMenu)
         .offset(x: showMenu ? 0: UIScreen.main.bounds.width)
         .animation(.easeInOut(duration: 0.2), value: showMenu)
         }
         }.background(Color.gray.opacity(showMenu ? 0.3: 0))
         
         }
         }
         .background(Const.primaryColor)
         }*/
    }

struct CategoryView: View {
    let isActive : Bool
    let text :String
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            Text(text)
                .font(.system(size:18))
                .fontWeight(.medium)
                .foregroundStyle(isActive ?  Const.primaryColor : Color.black.opacity(0.5))
            if(isActive){
                Color("Primary")
                    .frame(width: 15,height: 2)
                    .clipShape(.capsule)
            }
        }.padding(.horizontal)
    }
}


struct PopUpImageView: View {
    @Binding var isShowingPopUp: Bool
    let imageName: String
    
    var body: some View {
        VStack {
            Text("Detaylı Görüntü")
                .font(.title)
                .padding()
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    // Pop-up kapatma
                    isShowingPopUp = false
                }
        }
        .background(Color.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    ProfileView(hideTab: .constant(true), user: User.MockData[0])
}
