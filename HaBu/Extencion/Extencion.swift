//
//  Extencion.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else {
            return nil
        }
        
        color.setFill()
        let rect = CGRect(origin: .zero, size: self.size)
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        context.draw(cgImage, in: rect)
        context.clip(to: rect, mask: cgImage)
        context.addRect(rect)
        context.drawPath(using: .fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage
    }
    
}

extension Image {
    func withBool(with condition: Bool) -> Image {
        return self.foregroundStyle(condition ? Color.white : Color.black) as! Image
    }
}
extension Image {
    static func iconManager(_ iconManager: AppIcon, size: CGFloat, weight: Font.Weight, color: Color) -> some View {
        Image(systemName: iconManager.rawValue)
            .resizable()
            .frame(width: size, height: size)
            .font(Font.system(size: size, weight: weight))
            .foregroundColor(color)
            .scaledToFit()
    }
}
extension [LayoutSubviews.Element]{
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat{
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}

