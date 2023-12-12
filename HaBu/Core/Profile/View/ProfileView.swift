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
        NavigationStack {
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
        }
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
