//
//  User.swift
//  HaBu
//
//  Created by mert alp on 14.11.2023.
//

import Foundation
struct User : Identifiable,Codable,Hashable{
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
    let department : String
    
    
}
 
struct UniInfo :Identifiable,Codable ,Hashable{
    let id : String
    let faculty : String
    let depertmant : String
    let registerYear : String
    
}
extension User {
    static var MockData: [User] = [
        .init(id: "12345", email: "erbalta80@gmail.com", createdAt: "03.10.2000", username: "omer_erbalta", name: "Ömer", surName: "Erbalta", password: "123456", rating: 90, department: "Computer Science"),
                .init(id: "12346", email: "yusufAydın@gmail.com", createdAt: "04.10.2000", username: "chatYSF", name: "Yusuf", surName: "Aydın", password: "123456", rating: 55, department: "Electrical Engineering"),
                .init(id: "12347", email: "mertAlp@gmail.com", createdAt: "05.10.2000", username: "alp_mert", name: "Mert", surName: "Alp", password: "123456", rating: 50, department: "Mechanical Engineering"),
                .init(id: "12348", email: "asliCetin@gmail.com", createdAt: "06.10.2000", username: "asli_cetin", name: "Aslı", surName: "Çetin", password: "123456", rating: 40, department: "Civil Engineering"),
                .init(id: "12349", email: "emreYilmaz@gmail.com", createdAt: "07.10.2000", username: "emre_yilmaz", name: "Emre", surName: "Yılmaz", password: "123456", rating: 17, department: "Chemistry"),
                .init(id: "12350", email: "gizemArslan@gmail.com", createdAt: "08.10.2000", username: "gizem_arslan", name: "Gizem", surName: "Arslan", password: "123456", rating: 14, department: "Psychology"),
                .init(id: "12351", email: "burakDemir@gmail.com", createdAt: "09.10.2000", username: "burak_demir", name: "Burak", surName: "Demir", password: "123456", rating: 16, department: "Economics"),
                .init(id: "12352", email: "selinKaya@gmail.com", createdAt: "10.10.2000", username: "selin_kaya", name: "Selin", surName: "Kaya", password: "123456", rating: 19, department: "Political Science"),
                .init(id: "12353", email: "aliGüneş@gmail.com", createdAt: "11.10.2000", username: "ali_gunes", name: "Ali", surName: "Güneş", password: "123456", rating: 13, department: "History"),
                .init(id: "12354", email: "ayseKorkmaz@gmail.com", createdAt: "12.10.2000", username: "ayse_korkmaz", name: "Ayşe", surName: "Korkmaz", password: "123456", rating: 22, department: "Biology"),
                .init(id: "12355", email: "mehmetKaya@gmail.com", createdAt: "13.10.2000", username: "mehmet_kaya", name: "Mehmet", surName: "Kaya", password: "123456", rating: 24, department: "Mathematics"),
                .init(id: "12356", email: "elifAydın@gmail.com", createdAt: "14.10.2000", username: "elif_aydin", name: "Elif", surName: "Aydın", password: "123456", rating: 21, department: "Sociology"),
                .init(id: "12357", email: "canDemir@gmail.com", createdAt: "15.10.2000", username: "can_demir", name: "Can", surName: "Demir", password: "123456", rating: 23, department: "Physics"),
                .init(id: "12358", email: "merveKorkmaz@gmail.com", createdAt: "16.10.2000", username: "merve_korkmaz", name: "Merve", surName: "Korkmaz", password: "123456", rating: 25, department: "Marketing"),
                .init(id: "12359", email: "ahmetAydın@gmail.com", createdAt: "17.10.2000", username: "ahmet_aydin", name: "Ahmet", surName: "Aydın", password: "123456", rating: 27, department: "Finance"),
                .init(id: "12360", email: "gamzeYilmaz@gmail.com", createdAt: "18.10.2000", username: "gamze_yilmaz", name: "Gamze", surName: "Yılmaz", password: "123456", rating: 26, department: "Human Resources"),
                .init(id: "12361", email: "furkanArslan@gmail.com", createdAt: "19.10.2000", username: "furkan_arslan", name: "Furkan", surName: "Arslan", password: "123456", rating: 29, department: "Environmental Science"),
                .init(id: "12362", email: "zeynepCetin@gmail.com", createdAt: "20.10.2000", username: "zeynep_cetin", name: "Zeynep", surName: "Çetin", password: "123456", rating: 28, department: "Education"),
                .init(id: "12363", email: "keremGüneş@gmail.com", createdAt: "21.10.2000", username: "kerem_gunes", name: "Kerem", surName: "Güneş", password: "123456", rating: 30, department: "Industrial Engineering"),
                .init(id: "12364", email: "denizKaya@gmail.com", createdAt: "22.10.2000", username: "deniz_kaya", name: "Deniz", surName: "Kaya", password: "123456", rating: 32, department: "Architecture"),
                .init(id: "12365", email: "gülAydın@gmail.com", createdAt: "23.10.2000", username: "gul_aydin", name: "Gül", surName: "Aydın", password: "123456", rating: 31, department: "International Relations"),
    ]
}

