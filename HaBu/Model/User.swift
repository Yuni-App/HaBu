//
//  User.swift
//  HaBu
//
//  Created by mert alp on 14.11.2023.
//

import Foundation
struct User : Identifiable,Codable{
    //--USER INFO
    let id : String
    let email : String
    let createdAt : String
    var username : String
    var name : String
    var surName : String
    var password : String
    var profileImageUrl : [String]?
    var bio : String?
    var rating : Float
    var unıInfo : UniInfo?
    
    
}
 
struct UniInfo :Identifiable,Codable {
    let id : String
    let faculty : String
    let depertmant : String
    let registerYear : String
    
}
extension User{
    
    static var MockData : [User] = [
        .init(id: "12345", email: "erbalta80@gmail.com", createdAt: "03.10.2000", username: "omer_erbalta", name: "Ömer", surName: "Erbalta", password: "123456", rating: 20),
        .init(id: "12346", email: "yusufAydın@gmail.com", createdAt: "04.10.2000", username: "chatYSF", name: "Yusuf", surName: "Aydın", password: "123456", rating: 15),
        .init(id: "12347", email: "mertAlp@gmail.com", createdAt: "05.10.2000", username: "alp_mert", name: "Mert", surName: "Alp", password: "123456", rating: 12)
    ]
    
}
