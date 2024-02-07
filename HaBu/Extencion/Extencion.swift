//
//  Extencion.swift
//  HaBu
//
//  Created by OmerErbalta on 14.11.2023.
//

import Foundation
import UIKit
import SwiftUI
import Kingfisher

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
            .font(Font.system(size: size, weight: weight))
            .foregroundColor(color)
            .scaledToFit()
    }
}
extension Image {
    static func imageManager(image: AppImage , radius : CGFloat? = nil , backgroundColor : Color? = nil  , shadow : Color? = nil,width : CGFloat? = nil  , height : CGFloat? = nil
    ) -> some View {
        Image(image.rawValue)
            .resizable()
            .frame(width: width,height : height)
            .background(backgroundColor?.opacity(0.1) ?? Color.clear)
            .cornerRadius(radius ?? 0)
            .shadow(color: (shadow?.opacity(1) ?? Color.clear), radius: 5, x: 3, y: 3)
    }
}
extension [LayoutSubviews.Element]{
    func maxHeight(_ proposal: ProposedViewSize) -> CGFloat{
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}

extension View {
  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
extension View {
    func moveFocusOnReturn() -> some View {
        modifier(MoveFocusOnReturnModifier())
    }
}

struct MoveFocusOnReturnModifier: ViewModifier {
    @State private var textFieldTag = 0
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification)) { _ in
                self.textFieldTag += 1
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                DispatchQueue.main.async {
                    let textField = UITextField()
                    UIApplication.shared.windows.first?.addSubview(textField)
                    textField.isHidden = true
                    textField.becomeFirstResponder()
                }
            }
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = #"^.*@.*$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

//extension String {
//    var isValidEmail: Bool {
//        let balikesirEduTrRegex = #"^\d{12}@ogr\.balikesir\.edu\.tr$"#
//        return NSPredicate(format: "SELF MATCHES %@", balikesirEduTrRegex).evaluate(with: self)
//    }
//}
extension View {
    @MainActor func renderToUiImage(scale displayScale: CGFloat = 1.0) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = displayScale
        return renderer.uiImage
    }
    
}

extension UIImage {
    func compress(to maxSizeInKB: Int) -> Data? {
        var compression: CGFloat = 1.0
        guard var imageData = self.jpegData(compressionQuality: compression) else {
            return nil
        }
        
        var resizedImage = self
        while imageData.count > maxSizeInKB * 1024, compression > 0.1 {
            compression -= 0.1
            
            guard let newImageData = resizedImage.jpegData(compressionQuality: compression) else {
                break
            }
            
            imageData = newImageData
            resizedImage = resizedImage.resized(to: CGSize(width: resizedImage.size.width * 0.9, height: resizedImage.size.height * 0.9))
        }
        
        return imageData
    }
    
    func resized(to size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
