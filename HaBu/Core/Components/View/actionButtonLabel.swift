//
//  actionButtonLabel.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct actionButtonLabel: View {
    let button : actionButtons
    var number = ""
    init(button: actionButtons) {
        self.button = button
        
    }
    init(button:actionButtons,number:Int?) {
        self.button = button
        if let number = number {
            self.number = String(number)
        }
        
    }
    var body: some View {
        VStack {
            Image(uiImage: button.icon)
            Text("\(number) \(button.text)")
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .font(.footnote)
        }
    }
}

#Preview {
    actionButtonLabel(button: .like)
}

enum actionButtons {
    case like
    case bubble
    case send
    case savePost
    
    var icon : UIImage{
        switch self {
        case .like:
            return UIImage(systemName: "heart")!
        case .bubble:
           return UIImage(systemName: "bubble.right")!
        case .send:
           return UIImage(systemName: "paperplane")!
        case .savePost:
            return UIImage(systemName: "bookmark")!
        }
    }
    
    var text : String{
        switch self{
        case .like:
            return "like"
        case .bubble:
            return "yorum"
        case .send:
            return "send"
        case .savePost:
            return "kaydet"
        }
    }
}
