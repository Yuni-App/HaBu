//
//  Notification.swift
//  HaBu
//
//  Created by yusuf on 19.11.2023.
//

import Foundation

struct Notification: Identifiable, Codable{
    let id: String
    let type: NotificationType
    let userId:String
    let targetId:String
    let caption:String
    let createdAt:String
}


extension Notification {
    static var MOCK_DATA: [Notification] = [
        Notification(id: "0", type: .commentLike, userId: "0", targetId: "0", caption: "Gönderinizi beğendi", createdAt: "5s"),
        Notification(id: "1", type:.postComment, userId: "1", targetId: "1", caption: "Yorum yaptı", createdAt: "10s"),
        Notification(id: "2", type: .postLike, userId: "2", targetId: "2", caption: "Gönderinizi beğendi", createdAt: "15s"),
        Notification(id: "3", type: .postComment, userId: "3", targetId: "3", caption: "Takip etti", createdAt: "20s"),
        Notification(id: "4", type: .postComment, userId: "4", targetId: "4", caption: "Gönderinizi beğendi", createdAt: "25s"),
        Notification(id: "5", type: .postLike, userId: "5", targetId: "5", caption: "Yorum yaptı", createdAt: "30s"),
        Notification(id: "6", type: .postComment, userId: "6", targetId: "6", caption: "Gönderinizi beğendi", createdAt: "35s"),
        Notification(id: "7", type: .commentLike, userId: "7", targetId: "7", caption: "Takip etti", createdAt: "40s"),
        Notification(id: "8", type: .postComment, userId: "8", targetId: "8", caption: "Gönderinizi beğendi", createdAt: "45s"),
        Notification(id: "9", type: .postComment, userId: "9", targetId: "9", caption: "Yorum yaptı", createdAt: "50s")
    ]

}

enum NotificationType:Int,Codable{
    case postLike = 0
    case postComment = 1
    case commentLike = 2
    
}
