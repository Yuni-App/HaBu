//
//  Notification.swift
//  HaBu
//
//  Created by yusuf on 19.11.2023.
//

import Foundation

struct Notification: Identifiable, Codable{
    let id: String
    let type: String
    let userId:String
    let targetId:String
    let caption:String?
    let createdAt:String
}


extension Notification {
    static var MOCK_DATA: [Notification] = [
        Notification(id: "0", type: NotificationType.commentLike.rawValue, userId: "0", targetId: "0", caption: "Gönderinizi beğendi", createdAt: "5s"),
        Notification(id: "1", type: NotificationType.postComment.rawValue, userId: "1", targetId: "1", caption: "Yorum yaptı", createdAt: "10s"),
        Notification(id: "2", type:  NotificationType.postLike.rawValue, userId: "2", targetId: "2", caption: "Gönderinizi beğendi", createdAt: "15s"),
        Notification(id: "3", type:  NotificationType.postComment.rawValue, userId: "3", targetId: "3", caption: "Takip etti", createdAt: "20s"),
        Notification(id: "4", type:  NotificationType.postComment.rawValue, userId: "4", targetId: "4", caption: "Gönderinizi beğendi", createdAt: "25s"),
        Notification(id: "5", type:  NotificationType.postLike.rawValue, userId: "5", targetId: "5", caption: "Yorum yaptı", createdAt: "30s"),
        Notification(id: "6", type:  NotificationType.postComment.rawValue, userId: "6", targetId: "6", caption: "Gönderinizi beğendi", createdAt: "35s"),
        Notification(id: "7", type:  NotificationType.commentLike.rawValue, userId: "7", targetId: "7", caption: "Takip etti", createdAt: "40s"),
        Notification(id: "8", type:  NotificationType.postComment.rawValue, userId: "8", targetId: "8", caption: "Gönderinizi beğendi", createdAt: "45s"),
        Notification(id: "9", type:  NotificationType.postComment.rawValue, userId: "9", targetId: "9", caption: "Yorum yaptı", createdAt: "50s")
    ]

}

enum NotificationType:String,Codable{
    case postLike = "post_like"
    case postComment = "post_comment"
    case commentLike = "comment_like"
    
}
