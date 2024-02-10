//
//  Notification.swift
//  HaBu
//
//  Created by yusuf on 19.11.2023.
//

import Foundation
import Firebase

struct Notification: Identifiable, Codable{
    let id: String
    let postId: String
    let type: String
    let userId:String
    let targetId:String
    let createdAt:Timestamp
}


extension Notification {
    static var MOCK_DATA: [Notification] = [
     
    ]

}

enum NotificationType:String,Codable{
    case postLike = "post_like"
    case postComment = "post_comment"    
}
