//
//  CustomImageRectongle.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct CustomImageRectangle: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 537, height: 376)
            .background(
                Image(ImageManager.registerVector)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            )
    }
}

#Preview {
    CustomImageRectangle()
}
