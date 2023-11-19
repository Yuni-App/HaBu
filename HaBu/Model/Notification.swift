//
//  Notification.swift
//  HaBu
//
//  Created by yusuf on 19.11.2023.
//

import Foundation

struct Notification: Identifiable, Codable{
    let id: String
    let postId: String
    let commentId: String
    let userId: String
    let userName: String
    let status: String
}


extension Notification{
    static var MockData: [Notification] = [
            .init(id: "0", postId: "1", commentId: "12", userId: "456", userName: "yusuf", status: "yorumunuzu begendi"),
            .init(id: "1", postId: "2", commentId: "13", userId: "789", userName: "ahmet", status: "gönderinizi beğendi"),
            .init(id: "2", postId: "3", commentId: "14", userId: "123", userName: "mehmet", status: "gönderinize yorum attı"),
            .init(id: "3", postId: "4", commentId: "15", userId: "567", userName: "serkan", status: "gönderinizi beğendi"),
            .init(id: "4", postId: "5", commentId: "16", userId: "987", userName: "ali", status: "gönderinizi beğendi"),
            .init(id: "5", postId: "6", commentId: "17", userId: "321", userName: "veli", status: "gönderinizi beğendi"),
            .init(id: "6", postId: "7", commentId: "18", userId: "654", userName: "fatma", status: "gönderinize yorum attı"),
            .init(id: "7", postId: "8", commentId: "19", userId: "234", userName: "hatice", status: "yorumunuzu beğendi"),
            .init(id: "8", postId: "9", commentId: "20", userId: "890", userName: "ayse", status: "gönderinizi beğendi"),
            .init(id: "9", postId: "10", commentId: "21", userId: "098", userName: "ibrahim", status: "gönderinizi beğendi"),
            .init(id: "10", postId: "11", commentId: "22", userId: "901", userName: "melike", status: "gönderinize yorum attı"),
            .init(id: "11", postId: "12", commentId: "23", userId: "102", userName: "osman", status: "gönderinizi beğendi"),
            .init(id: "12", postId: "13", commentId: "24", userId: "203", userName: "elif", status: "gönderinizi beğendi"),
            .init(id: "13", postId: "14", commentId: "25", userId: "304", userName: "emir", status: "gönderinizi beğendi"),
            .init(id: "14", postId: "15", commentId: "26", userId: "405", userName: "zeynep", status: "gönderinize yorum attı"),
            .init(id: "15", postId: "16", commentId: "27", userId: "506", userName: "berk", status: "gönderinizi beğendi"),
            .init(id: "16", postId: "17", commentId: "28", userId: "607", userName: "ece", status: "gönderinizi beğendi")
    ]
}
