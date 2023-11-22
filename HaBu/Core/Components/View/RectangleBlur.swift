//
//  RectangleBlur.swift
//  HaBu
//
//  Created by mert alp on 22.11.2023.
//

import SwiftUI

struct RectangleBlur: View {
    var color : Color
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(color.opacity(0.1))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(1), radius: 2, x: 2, y:2)
    }
}

#Preview {
    RectangleBlur(color: .black)
}
