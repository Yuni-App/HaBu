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
        .init(id: "0", userId:"0", caption: "Sanki kodlar dans eder, akıcı ve hızlı,Wavy line'lar arasında ilerler, sıradışı.Işık hızında çözümler sunar, pratik ve kesin,Functions, loops, ve structs ile hayat verir veriye Tasarımı anlaşılır, geliştirici dostu, işte Swift!",imageUrl: "https://developer.apple.com/swift/images/swift-og.png", timeStamp: "05.12.2015", likeList:  []),
        .init(id: "1", userId: "1", caption: "Ömer, zeki, içten ve nezaketle dolu bir kişiliktir. Onun etrafında, insanların hemen fark edeceği samimi bir sıcaklık vardır. Başkalarına karşı duyarlılığı ve yardımseverliğiyle tanınır. Zorlu durumlarda bile sakinliğini koruyarak çözüm odaklı yaklaşımıyla öne çıkar. Ömer’in içindeki güç, sadece kendi başarısı için değil, etrafındaki insanların da başarıları için çaba göstermesine olanak tanır. Herkesin güçlü ve zayıf yanlarını anlayarak onlara destek olur ve hep birlikte daha iyi bir gelecek için çalışır. Ömer, sadece biri için değil, herkes için ilham kaynağıdır.", timeStamp: "11.11.2011", likeList:  [])
    ]
}
