//
//  FeedView.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import SwiftUI
import RxSwift
import RxCocoa

struct FeedView: View {
    @StateObject var  feedVM = FeedViewModel()
    @State var showCategoryFilter = false
    var bottomEdge:CGFloat
    @Binding var hideTab:Bool
    @State var offset:CGFloat = 0
    @State var lastOffset:CGFloat = 0
    @State var lastOffsetPositive:CGFloat = 0
    @State var messageBox = 20
    @State var addPostButtonPosition = CGPoint(x: 10, y: 20)
    @State var navigate = false
    @State var navigationPage : AnyView? = nil
    let disposeBag = DisposeBag()
    @State var posts = [Post]()
    @State private var yOffset : CGFloat = 0
    @State private var previousyOffset : CGFloat = 0
    @State var show :Bool = true
    @State var refresh = false
    
    func detectScrollOffset()-> some View{
        DispatchQueue.main.async {
          
            if lastOffsetPositive > 175 && refresh == false {
                refresh = true
                Task{
                    await feedVM.requestData()
                    print("update")
                    print(feedVM.newPostCount)

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        refresh = false
                        lastOffsetPositive = offset
                    }
                   
                }
            }
           
        
        }
        return Color.clear
    }
    private func setupBinding(){
        feedVM
            .postsData
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { posts in
                self.posts = posts
            }.disposed(by: disposeBag)
    }
    var body: some View {
        
        ZStack {
            VStack {
                ScrollViewReader{ value in
                    ZStack{
                        Button(action: {
                            lastOffsetPositive = 180
                            withAnimation {
                                value.scrollTo(posts[0].id,anchor: .bottom)
                                
                            }
                            print("tıklandı")
                        }, label: {
                            Text("+ \(feedVM.newPostCount) post")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal,15)
                                .padding(.vertical,8)
                        })
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 15, style: .continuous))
                        .scaleEffect(hideTab ? 1.5 :1 )
                        .offset(x:hideTab ? Const.width * 0.4 : 0 ,y: feedVM.newPostCount > 0 ? (hideTab ? Const.height * -0.42 : Const.height * -0.38) :Const.height * -0.7)
                        .zIndex(10)
                        
                        ScrollView(.vertical,showsIndicators: false){
                            if posts == []{
                                VStack (alignment:.center){
                                    HStack(spacing:20){
                                        ZStack{
                                            ProgressView()
                                        }
                                        Text(" Yükleniyor..")
                                    }
                                    .padding(.top,Const.height * 0.12)
                                }
                                .frame(width: Const.width)
                            }
                            else{
                                VStack (alignment:.center){
                                    if lastOffsetPositive > 170 || refresh == true {
                                        ProgressView()
                                            .frame(width: 50,height: 50)
                                            .scaleEffect(1.25)
                                            .padding(.vertical,offset > 0 ?  -offset : 0)
                                    }
                                    else{
                                        Image.iconManager(.down_arrow, size: 20, weight: .bold, color:.gray)
                                            .fontWeight(.bold)
                                            .opacity(offset > 30 ? 1:0)
                                            .rotationEffect(.degrees(offset < 180 ? offset : 180), anchor: .center)
                                            .scaleEffect(offset / 100)
                                            .padding(.vertical,offset > 0 ?  -offset : 0)
                                    }
                                    ForEach(posts , id: \.id){post in
                                        FeedViewCell(post: post,user: User.MockData[0]).id(post.id)
                                        Divider()
                                    }
                                    
                                }
                                .padding(.top,Const.height * 0.12)
                                .overlay(
                                    GeometryReader{proxy -> Color in
                                        let minY = proxy.frame(in: .named("SCROLL")).minY
                                        let durationOffset: CGFloat = 35
                                        DispatchQueue.main.async {
                                            if minY < offset{
                                                if offset < 0 && -minY > (lastOffset + durationOffset){
                                                    withAnimation(.easeOut ){
                                                        hideTab = true
                                                    }
                                                    lastOffset = -offset
                                                }
                                                
                                                
                                            }
                                            if offset > 0 && minY > lastOffsetPositive{
                                                lastOffsetPositive = offset
                                            }
                                            if offset < 16{
                                                lastOffsetPositive = 0
                                            }
                                            if minY > offset && -minY < (lastOffset - durationOffset){
                                                withAnimation(.easeOut){
                                                    hideTab = false
                                                }
                                                lastOffset = -offset
                                                
                                            }
                                            
                                            self.offset = minY
                                        }
                                        return Color.clear
                                        
                                    }
                                    
                                )
                                .padding()
                                .padding(.bottom,15 + bottomEdge + 35)
                            }
                            
                            
                        }
                        .background(GeometryReader{_ in
                            self.detectScrollOffset()
                        })
                        .onAppear{
                            setupBinding()
                        }
                        .coordinateSpace(name:"SCROLL")
                        //TollBar
                        .overlay(
                            FeedViewTollBar(showCategoryFilter: $showCategoryFilter, messageBox: $messageBox)
                                .background(.white)
                                .offset(y:hideTab ? (-15 - 70 ) :0)
                            ,alignment: .top
                        )
                        .ignoresSafeArea(.all,edges: .all)
                        //Slidable Button
                        .overlay(
                            Buttons.SlidableButton(action: {
                                navigate = true
                                navigationPage = AnyView(AddPostView())
                            }, position: CGPoint(x: 20, y: 40), dragDirection: .right, text: "Post Ekle", color: Const.primaryColor, textColor: .white)
                            .offset(x:hideTab ? -Const.width * 0.5:0)
                            
                        )
                        .sheet(isPresented: $showCategoryFilter) {
                            CategoryFilterBottomSheet()
                                .presentationDetents([.height(Const.height * 0.6)])
                        }
                    }
                }
            }
              
            .navigationDestination(isPresented: $navigate) {
                navigationPage
        }
        }
     
        
    }
}


#Preview {
    TabbarView()
}


struct FeedViewTollBar:View {
    @Binding var showCategoryFilter:Bool
    @Binding var messageBox : Int
    
    @Environment(\.colorScheme) var sheme
    var body: some View {
        VStack{
            HStack{
                Text("Yuni").foregroundStyle(Const.primaryColor).font(.custom("Kodchasan-Bold", size: 40))
                    .padding(10)
                Spacer()
                
                Button(action: {
                    showCategoryFilter = true
                    
                }, label: {
                    Image.iconManager(.filter, size: 20, weight: .bold, color: .black).padding(20)
                })
                //message icon
                //this will active at next version
              /*
               
               Button(action: {
                   // -> MessageBox View
                   
               }, label: {
                   Image.iconManager(.tray, size: 25, weight: .bold, color: .black)
                       .padding(.top,10)
                       .overlay(
                           Text("\(messageBox < 100 ? messageBox: 99)+")
                               .font(.caption2)
                               .fontWeight(.bold)
                               .foregroundStyle(sheme == .dark ? .black : .white)
                               .padding(.vertical,2)
                               .padding(.horizontal,3)
                               .background(.red, in: Capsule())
                               .background(
                                   Capsule().stroke(sheme == .dark ? .black:.white,lineWidth:2)
                               )
                           
                           ,alignment: .topTrailing
                       )
                       .padding(20)
                   
               }
                      
               )
               */
                
                
                
            }
            
        }
        
        .padding(.horizontal,15)
        .padding(.top, 15)
        .overlay(
            Rectangle()
                .stroke().opacity(0.3)
                .background(Color.clear)
        )
    }
}

struct CircleA : View {
    @Binding var yOffset:CGFloat
    var size :CGFloat = 80
    var degress:CGFloat = 60
    var color :Color
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 5,lineCap: .round,lineJoin: .round))
            .frame(width: size,height: size)
            .rotationEffect(.degrees(degress + yOffset))
            .foregroundStyle(color)
    }
}
