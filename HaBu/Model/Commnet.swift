//
//  Commnet.swift
//  HaBu
//
//  Created by yusuf on 14.11.2023.
//

import Foundation
import Firebase

struct Comment: Identifiable, Codable{
    let id: String
    let comment: String
    let userId: String
    let postId : String
    let createdAt : Timestamp
    var user : User? = nil
}


extension Comment{
    static var MockData :[Comment] = [
        .init(id: "0", comment: "Hata", userId: "Hata", postId: "0", createdAt: Timestamp(date: .now), user: User.MockData[0])
        
    ]
}
