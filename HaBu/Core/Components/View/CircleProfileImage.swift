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
            return Const.width * 0.1
        case .Center:
            return Const.width * 0.3
        case .Right:
            return Const.width * 0.1
        }
    }
    var Position : CGPoint{
        switch self {
        case .Left:
            return CGPoint(x:Const.width * 0.25, y :0 )
        case .Center:
            return CGPoint(x:Const.width * 0.5,y: Const.height * 0.1)
        case .Right:
            return CGPoint(x:Const.width * 0.75, y :0)
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
    var userImage : Any?
    var index : Int?
    var size : ProfileImageSize?
    
    init(userIamgeUrl: String, size: ProfileImageSize) {
        self.userIamgeUrl = userIamgeUrl
        self.size = size
    }
    init(index : Int,userImage: Any? = nil){
        self.userIamgeUrl = ""
        self.index = index
        if let userImage = userImage as? KFImage{
            self.userImage = userImage
        }
        else if let userImage = userImage as? Image{
            self.userImage = userImage
        }
        
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
                Image("profil3")
                    .resizable()
                    .clipShape(.rect(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .frame(width: size.deminsion ,height: size.deminsion)
            }
        }
        if let index = self.index{
            let value = ImageLocationAndSize.fromRawValue(index)
            if let image = userImage as? KFImage {
                image
                    .resizable()
                    .clipShape(.rect(cornerRadius: 15))
                    .frame(width: value!.size, height: value!.size)
                    .position(value!.Position)
                    .foregroundStyle(.white)
            }
            else if let image = userImage as? Image{
                image
                    .resizable()
                    .clipShape(.rect(cornerRadius: 15))
                    .frame(width: value!.size, height: value!.size)
                    .position(value!.Position)
                    .foregroundStyle(.white)
            }
            else{
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .clipShape(.rect(cornerRadius: 15))
                    .frame(width: value!.size, height: value!.size)
                    .position(value!.Position)
                    .foregroundStyle(.white)
            }

                
            
        }
    }
}

#Preview {
    CircleProfileImage( index: 2)
}
