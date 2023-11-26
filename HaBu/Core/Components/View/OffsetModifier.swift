//
//  CustomCorner.swift
//  HaBu
//
//  Created by OmerErbalta on 26.11.2023.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset : CGFloat
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader{ proxy -> Color in
                let minY = proxy.frame(in: .named("SCROLL")).minY
                print(minY)
                DispatchQueue.main.async {
                    self.offset = minY
                }
                return Color.clear
            }
            ,alignment: .top
        )
        
    }
}

struct CustomCorner : Shape{
    var corners: UIRectCorner
    var radius: CGFloat
    func path (in rect:CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
