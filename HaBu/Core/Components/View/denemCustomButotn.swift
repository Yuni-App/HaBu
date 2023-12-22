//
//  denemCustomButotn.swift
//  HaBu
//
//  Created by mert alp on 22.12.2023.
//

import Foundation
import SwiftUI

struct CustomButtonDeneme<Content: View>: View {
    let action: () -> Bool
    let destination: Content
    let label: () -> Label
    
    @State private var isActiveDestination: Bool = false

    var body: some View {
        NavigationLink(
            destination: destination,
            isActive: $isActiveDestination,
            label: {}
        )
        Button(action: {
            if action() {
                isActiveDestination = true
            }
        }) {
            label()
        }
    }
}

extension CustomButtonDeneme {
    struct Label: View {
        let title: String
        let backgroundColor: Color
        let textColor: Color
        
        init(_ title: String, backgroundColor: Color, textColor: Color) {
            self.title = title
            self.backgroundColor = backgroundColor
            self.textColor = textColor
        }
        
        var body: some View {
            Text(title)
                .padding()
                .frame(width: 200, height: 50)
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(10)
        }
    }
}
