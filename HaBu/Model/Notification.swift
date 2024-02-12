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
    var post: Post?
    let type: String
    let user:User?
    let targetId:String
    let createdAt:Timestamp
}


extension Notification {
    static var MOCK_DATA: [Notification] = [
        Notification(id: "0", post: Post.MockData[0], type: " ", user: User.MockData[0], targetId: " ", createdAt: Timestamp(date: Date())),
    ]
}
enum NotificationType:String,Codable{
    case postLike = "post_like"
    case postComment = "post_comment"    
}
