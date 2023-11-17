//
//  ProfileView.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI





struct ProfileView : View {
    @State private var showMenu: Bool = false
    @State var editButtonPosition = CGPoint(x:Const.width, y : Const.height / 4.5)
    let user : User
    var body: some View {
            NavigationStack {
                VStack{
                        ScrollView{
                            HStack{
                               
                                Spacer()
                                Button{
                                    self.showMenu.toggle()
                                }label: {
                                    if showMenu {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                    }else{
                                        Image(systemName: "text.justify")
                                            .foregroundColor(.white)
                                    }
                                    
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
                                                    
                                                }, label: {
                                                    CircleProfileImage(userIamgeUrl: "", size: .lage)
                                            })
                                                HStack{
                                                    Image(systemName: "largecircle.fill.circle")
                                                        .resizable()
                                                        .frame(width: 5,height: 5)
                                                        .foregroundStyle(.white)
                                                    
                                                    Image(systemName: "largecircle.fill.circle")
                                                        .resizable()
                                                        .frame(width: 5,height: 5)
                                                        .foregroundStyle(.black)
                                                    
                                                    Image(systemName: "largecircle.fill.circle")
                                                        .resizable()
                                                        .frame(width: 5,height: 5)
                                                        .foregroundStyle(.black)
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
                                        HStack{
                                            Image(systemName:"chevron.backward")
                                                .fontWeight(.bold)
                                                .font(.subheadline)
                                            Text(" Edit")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                        } //edit button
                                        .padding(.vertical,5)
                                        .padding(.horizontal,10)
                                        .padding(.trailing,100)
                                        .background(.white)
                                        .clipShape(
                                            .rect(
                                                topLeadingRadius: 20,
                                                bottomLeadingRadius: 20,
                                                bottomTrailingRadius: 0,
                                                topTrailingRadius: 0
                                            )
                                        )
                                        .padding(.bottom,10)
                                        .position(editButtonPosition)
                                        .gesture(DragGesture().onChanged({ value in
                                            if value.translation.width > -50{
                                                print(value.translation.width)
                                                editButtonPosition = CGPoint(x: Const.width + value.translation.width, y : Const.height / 4.5)
                                            }
                                            
                                        })
                                            .onEnded({ _ in
                                                editButtonPosition = CGPoint(x: Const.width , y : Const.height / 5)
                                            })
                                        )
                                    }
                                }.frame(width: Const.width,height: Const.height * 0.25)
                               
                            }
                            //postGrid
                            VStack{
                                ForEach(Post.MockData,id:\.id){post in
                                    Text("12123123")
                                        .font(.title)
                                        .padding(.vertical,100)
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
                }
                .background(Const.primaryColor)
            }

        }













struct ProfilseView: View {
    //properties
    
    @State private var showMenu: Bool = false
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false
    @State private var offset: CGSize = .zero
    @State var editButtonPosition = CGPoint(x:Const.width, y : Const.height / 5)
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, _, _ in
                self.completedLongPress = currentState
            }
            .onChanged { value in
                withAnimation {
                    self.offset.width = -20
                }
            }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero // Tıklama işlemi bittiğinde eski yerine geri dön
                }
            }
    }
    
   //body view
    
    var body: some View {
        NavigationView{
            
            ZStack {
                VStack{
                    VStack {
                        HStack{
                            //Image
                            CircleProfileImage(userIamgeUrl: "", size: .xlage)
                                .padding(.leading)
                            
                            //User Info
                            VStack (alignment:.leading){
                                Text("Yusuf Aydın")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text("MMF/bilgisayar")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                    Text("145").font(.subheadline)
                                }
                                
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
                                
                            }
                            .padding(.horizontal,30)
                            
                            
                        }.frame(height: Const.height * 0.25)
                    }
                    .frame(height: Const.height * 0.25)
                    
                    VStack{
                        
                    }
                    .frame(width: Const.width, height: Const.height * 0.75)
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
                .toolbar {
                    //show menu button
                    Button{
                        self.showMenu.toggle()
                    }label: {
                        if showMenu {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                        }else{
                            Image(systemName: "text.justify")
                                .foregroundColor(.white)
                        }
                        
                    }
                    
                }
                HStack{
                    Image(systemName:"chevron.backward")
                        .fontWeight(.bold)
                        .font(.subheadline)
                    Text(" Edit")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.vertical,5)
                .padding(.horizontal,10)
                .padding(.trailing,100)
                .background(.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                )

                .padding(.bottom,10)
                .position(editButtonPosition)
                .gesture(DragGesture().onChanged({ value in
                    if value.translation.width > -50{
                        print(value.translation.width)
                        editButtonPosition = CGPoint(x: Const.width + value.translation.width, y : Const.height / 5)
                    }
                   
                })
                    .onEnded({ _ in
                        editButtonPosition = CGPoint(x: Const.width , y : Const.height / 5)
                    })
                )
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        SideMenu()
                            .offset(x: showMenu ? 0: UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.2), value: showMenu)
                    }
                }.background(Color.gray.opacity(showMenu ? 0.3: 0))
                //profile screen makes pale "solgunlaştırır"
                
                
            }
            
            
        }
        
        
    }
    
    
}

#Preview {
    ProfileView( user: User.MockData[0])
}

