//
//  SearchItem.swift
//  HaBu
//
//  Created by yusuf on 1.12.2023.
//

import SwiftUI

struct SearchItem: View {
    var user: User
    var ratingSorted: Bool
    
    var body: some View {
        NavigationLink(destination: Text("ProfileView")) {
            HStack() {
                Spacer()
                VStack() {
                    Text("\(user.name) \(user.surName)")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                    Text(user.department).opacity(0.6).font(.caption2).foregroundStyle(Color.white)
                    
                }.frame(width: Const.width * 0.3 ,height: Const.height * 0.12 ,alignment: .topLeading)
                Spacer()
                Image("profil3").resizable()
                    .frame(width: Const.width * 0.5, height: Const.height * 0.12).mask(
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: Const.height * 0.12)) // Sol alt köşe
                            path.addLine(to: CGPoint(x: Const.width * 0.5, y: Const.height * -0.25)) // Üst orta kısma kadar olan nokta
                            path.addLine(to: CGPoint(x: Const.width * 0.5, y: Const.height * 0.12)) // Sağ alt köşe
                            path.closeSubpath()
                        }
                        .fill(style: FillStyle(eoFill: true))
                    )
                
                
                /*
                 HStack {
                 switch (ratingSorted, user.rating) {
                 case (false, 20...30):
                 Image(systemName:"star.fill")
                 .foregroundColor(Color(UIColor(hex: "#CD7F32")))
                 case(false, 30...40):
                 Image(systemName:"star.fill")
                 .foregroundColor(Color(UIColor(hex: "#808080")))
                 case (false, 40...65):
                 
                 Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                 )
                 
                 case (false, 65...100):
                 Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                 )
                 Image(systemName: "star.fill").foregroundStyle(Color(UIColor(hex: "#FFD700"))
                 )
                 Image(systemName: "star.fill").resizable().frame(width: Const.width * 0.03, height: Const.height * 0.015).foregroundStyle(Color(UIColor(hex: "#FFD700")).secondary
                 )
                 
                 
                 default:
                 Image(systemName: "star")
                 .foregroundColor(Color.gray)
                 }
                 }.frame(width: Const.width * 0.2)
                 */
            }
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.02, green: 0.14, blue: 0.24), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.02, green: 0.14, blue: 0.24).opacity(0.77), location: 0.44),
                        Gradient.Stop(color: Color(red: 0.02, green: 0.14, blue: 0.24).opacity(0.43), location: 0.89),
                        Gradient.Stop(color: Color(red: 0.02, green: 0.14, blue: 0.25).opacity(0.73), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )).cornerRadius(10)
                .cornerRadius(7)
                .overlay(
                RoundedRectangle(cornerRadius: 7)
                .inset(by: 2)
                .stroke(.black, lineWidth: 4)
                )
                .frame(width: Const.width * 0.9, height: Const.height * 0.13, alignment: .leading)
        }
    }
}

#Preview {
    SearchItem(user: User.MockData[0], ratingSorted: true)
}
