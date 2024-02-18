//
//  Notification.swift
//  HaBu
//
//  Created by yusuf on 19.11.2023.
//

import Foundation
import Firebase 

struct NotificationData: Identifiable, Codable {
    let id: String
    let postId: String
    let type: String
    let userId: String
    let targetId: String
    let createdAt: Timestamp
    var post : Post?
    var user : User?
}



enum NotificationType:String,Codable{
    case postLike = "post_like"
    case postComment = "post_comment"    
}
