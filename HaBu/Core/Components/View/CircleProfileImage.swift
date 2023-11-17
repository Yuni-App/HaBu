//
//  Components.swift
//  HaBu
//
//  Created by mert alp on 14.11.2023.
//
import SwiftUI
import Kingfisher


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
    let size : ProfileImageSize
    init(userIamgeUrl: String, size: ProfileImageSize) {
        self.userIamgeUrl = userIamgeUrl
        self.size = size
    }
    var body: some View {
        if  userIamgeUrl != ""{
           Image(userIamgeUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.deminsion,height:size.deminsion)
                .clipShape(.circle)
                .padding(.all,5)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1)
                )
                
        }
        else{
            Image(systemName:"person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: size.deminsion ,height: size.deminsion)
                .clipShape(.circle)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    CircleProfileImage(userIamgeUrl: "", size:.xsmall)
}
