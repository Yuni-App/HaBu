//
//  ProfileView.swift
//  HaBu
//
//  Created by OmerErbalta on 16.11.2023.
//

import SwiftUI



struct ProfileView: View {
    //properties
    
    @State private var showMenu: Bool = false
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false
    @State private var offset: CGSize = .zero
    
    
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
                    HStack{
                        
                        CircleProfileImage(userIamgeUrl: "", size: .xlage)
                            .frame(width: 80).padding()
                        VStack {
                            Text("Yusuf Aydın")
                                .font(.title2)
                            Text("MMF/bilgisayar").font(.subheadline)
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("145").font(.subheadline)
                            }
                            
                        }
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
                        // **********
                        Spacer()
                        
                        
                        VStack{
                            
                            
                            Spacer()
                            Text("4 Post").frame(width: 75, height: 20).padding(.vertical, 4).padding(.horizontal, 8)
                            Spacer()
                            
                            //edit button
                            Button(action: {
                                //Goes to profile editing page based on button
                                print("tapped")
                            }) {
                                Spacer()
                                Text("<Edit").font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .frame(height: 43)
                                    .background(Color.white)
                                    .clipShape(
                                        .rect(
                                            topLeadingRadius: 20,
                                            bottomLeadingRadius: 20,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 0
                                        )
                                    )
                                    .offset(offset)
                                    .gesture(longPressGesture)
                                
                            }
                        }.frame(width: 95,height: 175)
                        
                        
                    }.frame(height: 200)
                        .background(Color(red: 0.33, green: 0.74, blue: 0.72))
                    
                    Spacer()
                    VStack{
                        Text("dsadasda")
                    }
                    
                    
                }
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
    ProfileView()
}

