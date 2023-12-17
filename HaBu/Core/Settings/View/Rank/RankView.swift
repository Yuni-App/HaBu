//
//  RankView.swift
//  HaBu
//
//  Created by OmerErbalta on 3.12.2023.
//

import SwiftUI
import Charts


//this will add next version
/*
struct RankView: View {
    var colors: [(color: Color, title: String)] = [
        (Color.red, "Gönderi"),
        (Color.brown, "Yorum"),
        (Color.green, "Beğeni"),
        (Color.yellow, "Takip")
    ]

    var body: some View {
        VStack(alignment:.center){
            // Texts
            Text("Tebrikler")
                .font(.custom("IrishGrover-Regular", size: 40))
                .fontWeight(.bold)
            Text("Balıkesir Üniversitesi içinde \n Bu ayki sıralamanız : 10")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            //Madal Image
            Image("madal")
                .overlay(
                    Text("10")
                        .font(.custom("IrishGrover-Regular", size: 40))
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(.bottom,60)
                    ,alignment:.center
                )
            
            // Grapich Card
          Card()
                .padding()
            //Detail Button
            
            Button(action: {
                
            }, label: {
                Text("Bütün Veriler")
                
                
            })
            .padding()
            .background(.orange)
            .clipShape(.rect(cornerRadius: 10))
            
            
        }
        .foregroundStyle(.white)
        .frame(width:Const.width,height: Const.height)
        .background(Const.thirColor)
        .overlay(
            Buttons.backButton {
                print("back")
            }
                .padding()
            ,alignment: .topLeading
        )
    }
    @ViewBuilder
    func Card()-> some View{
        HStack{
            PieChart()
                .padding()
            Spacer()
            VStack(alignment:.leading){
                Text("Ocak Ayı \n Verileri")
                    .font(.title3)
                    .fontWeight(.bold)
                ForEach(colors,id: \.title){item in
                    HStack(alignment:.center){
                        Rectangle()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(item.color)
                        Text(item.title)
                            .font(.footnote)
                            .fontWeight(.bold)
                    }
                    
                }
               
                
            }
            .padding()
            .foregroundStyle(.white)
        }
        .frame(width: Const.width * 0.9,height: Const.height * 0.25)
        .background(Const.fourthColor)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(radius: 10,x: 4,y: 2)

       
    }
    
    @ViewBuilder
    private  func PieChart() -> some View{
        Text("Pie Chart")
    }
}


#Preview {
    RankView()
}
private  struct Product: Identifiable {
    let id = UUID()
    let title: String
    let revenue: Double
}

*/
