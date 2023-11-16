//
//  BackgroundColor.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct BackgroundLinearColor: View {
    var body: some View {
        LinearGradient(
        stops: [
        Gradient.Stop(color: Color(UIColor(hex: "55BDB7")), location: 0.00),
        Gradient.Stop(color: Color(UIColor(hex: "40908C")), location: 0.48),
        Gradient.Stop(color: Color(UIColor(hex: "13446C")), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
        )    }
}

#Preview {
    BackgroundLinearColor()
}
