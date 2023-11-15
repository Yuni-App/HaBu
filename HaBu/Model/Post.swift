//
//  Post.swift
//  HaBu
//
//  Created by yusuf on 14.11.2023.
//

import Foundation



struct Post : Identifiable,Codable{
    let id : String
    let userId : String
    let caption : String
    var imageUrl : String?
    let timeStamp : String
    var likeList : [String]
    
}
extension Post{
    static var MockData : [Post] = [
        .init(id: "123", userId: User.MockData[0].id, caption: "Sanki kodlar dans eder, akıcı ve hızlı,Wavy line'lar arasında ilerler, sıradışı.Işık hızında çözümler sunar, pratik ve kesin,Functions, loops, ve structs ile hayat verir veriye Tasarımı anlaşılır, geliştirici dostu, işte Swift!",imageUrl: "https://developer.apple.com/swift/images/swift-og.png", timeStamp: "05.12.2015", likeList:  []),
        .init(id: "1234", userId: User.MockData[2].id, caption: "Amele",imageUrl: "", timeStamp: "11.11.2011", likeList:  [])
    ]
}
