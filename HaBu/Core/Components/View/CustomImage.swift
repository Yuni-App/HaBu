//
//  CustomImageRectongle.swift
//  HaBu
//
//  Created by mert alp on 15.11.2023.
//

import SwiftUI

struct CustomImage: View {
    var width : Double
    var height : Double
    var imagePath : String
    var body: some View {
        Image(imagePath)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .frame(width: width , height: height)
    }
}

#Preview {
    CustomImage(width: 150, height: 150, imagePath: ImageManager.infoVector)
}
