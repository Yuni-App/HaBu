//
//  Components.swift
//  HaBu
//
//  Created by mert alp on 14.11.2023.
//
import SwiftUI
import Kingfisher


enum ImageLocationAndSize:Int{
    case Center = 1
    case Right = 2
    case Left = 0
    
    var size : CGFloat{
        switch self {
        case .Left:
            return Const.width * 0.12
        case .Center:
            return Const.width * 0.3
        case .Right:
            return Const.width * 0.12
        }
    }
    var Position : CGPoint{
        switch self {
        case .Left:
            return CGPoint(x:Const.width * 0.25, y : 0 )
        case .Center:
            return CGPoint(x:Const.width / 2,y: Const.height * 0.1)
        case .Right:
            return CGPoint(x:Const.width * 0.75, y : 0)
        }
    }
    static func fromRawValue(_ rawValue: Int) -> ImageLocationAndSize? {
          return ImageLocationAndSize(rawValue: rawValue)
      }
    
}
enum ProfileImageSize{
    case xxxsmall
    case xxsmall
    case xsmall
    case small
    case medium
    case lage
    case xlage
    case xxlage
    
    var deminsion : CGFloat{
        switch self {
        case .xxxsmall:
            return 20
        case .xxsmall:
            return 30
        case .xsmall:
            return 40
        case .small:
            return 50
        case .medium:
            return 60
        case .lage:
            return 70
        case .xlage:
            return 80
        case .xxlage:
            return 90
        }
    }
}

struct CircleProfileImage: View {
    let userIamgeUrl : String
    var index : Int?
    var size : ProfileImageSize?
    
    init(userIamgeUrl: String, size: ProfileImageSize) {
        self.userIamgeUrl = userIamgeUrl
        self.size = size
    }
    init(userImage:String,index : Int){
        self.userIamgeUrl = userImage
        self.index = index
    }
    var body: some View {
        if let size = self.size{
            if  userIamgeUrl != ""{
                Image(userIamgeUrl)
                    .resizable()
                    .clipShape(.rect(cornerRadius: 30))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .frame(width: size.deminsion ,height: size.deminsion)
                
            }
            else{
                Image("profil1")
                    .resizable()
                    .clipShape(.rect(cornerRadius: 30))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .frame(width: size.deminsion ,height: size.deminsion)
            }
        }
        if let index = self.index{
            let value = ImageLocationAndSize.fromRawValue(index)
            Image(userIamgeUrl)
                .resizable()
                .clipShape(.rect(cornerRadius: 30))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1)
                )
                .frame(width: value!.size, height: value!.size)
                .position(value!.Position)
                
            
        }
    }
}

#Preview {
    CircleProfileImage(userIamgeUrl: "", size:.xlage)
}
