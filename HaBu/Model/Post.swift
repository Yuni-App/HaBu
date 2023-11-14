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
    let imageUrl : String?
    let timeStamp : String
    var likeList : [String]
    
}
