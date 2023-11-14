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
