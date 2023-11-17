//
//  CustomImageRectongle.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct CustomImageRectangle: View {
    var width : Double
    var height : Double
    var imagePath : String
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: width , height: height)
            .background(
                Image(imagePath)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            )
    }
}

#Preview {
    CustomImageRectangle(width: 50, height: 50, imagePath: ImageManager.infoVector)
}
