//
//  actionButtonLabel.swift
//  HaBu
//
//  Created by OmerErbalta on 15.11.2023.
//

import SwiftUI

struct ActionButton: View {
    let button : actionButtons
    var number = ""
    var action: () -> Void
    init(button: actionButtons,action : @escaping () -> Void) {
        self.button = button
        self.action = action
    }
    init(button:actionButtons,number:Int?,action : @escaping () -> Void) {
        self.button = button
        if let number = number {
            self.number = String(number)
        }
        self.action = action

    }
    var body: some View {
        VStack {
            Button(action: {
                
            }, label: {
                Image(uiImage: button.icon)
                
        })
            Text("\(number) \(button.text)")
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .font(.footnote)
        }
    }
}

#Preview {
    ActionButton(button: .like) {
        
    }
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
