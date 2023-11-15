//
//  IGTextFieldModifier.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import Foundation
import SwiftUI
struct IGTextFieldModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
        .font(.subheadline)
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 15))
        .padding(.horizontal,15)
    }
}
