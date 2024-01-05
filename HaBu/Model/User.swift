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
    let created_at : String
    var username : String
    var name : String?
    var surname : String?
    var password : String
    var profileImageUrl : [String]?
    var bio : String?
    var rating : Float
    let department : String
}
extension User {
    static var MockData: [User] = [
        .init(id: "DuZ0Jo1m7sOnARgym09ZP0Yv7i22", email: "erbalta80@gmail.com", created_at: "03.10.2000", username: "omer_erbalta", name: "Ömer", surname: "Erbalta", password: "123456", profileImageUrl: ["https://yt3.googleusercontent.com/2HHB6DuR4aCIMGPyaOb9AUUmB-TIVY8kVVii2mYd_7l1qkhawAL7thr3-51S7_8yNZgxl-ex=s900-c-k-c0x00ffffff-no-rj","https://i.pinimg.com/736x/32/6d/15/326d1586b612944a70971389a7cf4faa.jpg"], bio: "Senior Swift Developer Aynı Zamanda YUNİ de patron,ceo,takım lideri,yatırımcı,yüzde 98 hisse sahibi,yusufun ve mertin sahibi", rating: 90, department: "Computer Science"),
        .init(id: "12346", email: "yusufAydın@gmail.com", created_at: "04.10.2000", username: "chatYSF", name: "Yusuf", surname: "Aydın", password: "123456", rating: 55, department: "Electrical Engineering"),
        .init(id: "12347", email: "mertAlp@gmail.com", created_at: "05.10.2000", username: "alp_mert", name: "Mert", surname: "Alp", password: "123456", rating: 50, department: "Mechanical Engineering"),
        .init(id: "12348", email: "asliCetin@gmail.com", created_at: "06.10.2000", username: "asli_cetin", name: "Aslı", surname: "Çetin", password: "123456", rating: 40, department: "Civil Engineering"),
        .init(id: "12349", email: "emreYilmaz@gmail.com", created_at: "07.10.2000", username: "emre_yilmaz", name: "Emre", surname: "Yılmaz", password: "123456", rating: 17, department: "Chemistry"),
        .init(id: "12350", email: "gizemArslan@gmail.com", created_at: "08.10.2000", username: "gizem_arslan", name: "Gizem", surname: "Arslan", password: "123456", rating: 14, department: "Psychology"),
        .init(id: "12351", email: "burakDemir@gmail.com", created_at: "09.10.2000", username: "burak_demir", name: "Burak", surname: "Demir", password: "123456", rating: 16, department: "Economics"),
        .init(id: "12352", email: "selinKaya@gmail.com", created_at: "10.10.2000", username: "selin_kaya", name: "Selin", surname: "Kaya", password: "123456", rating: 19, department: "Political Science"),
        .init(id: "12353", email: "aliGüneş@gmail.com", created_at: "11.10.2000", username: "ali_gunes", name: "Ali", surname: "Güneş", password: "123456", rating: 13, department: "History"),
        .init(id: "12354", email: "ayseKorkmaz@gmail.com", created_at: "12.10.2000", username: "ayse_korkmaz", name: "Ayşe", surname: "Korkmaz", password: "123456", rating: 22, department: "Biology"),
        .init(id: "12355", email: "mehmetKaya@gmail.com", created_at: "13.10.2000", username: "mehmet_kaya", name: "Mehmet", surname: "Kaya", password: "123456", rating: 24, department: "Mathematics"),
        .init(id: "12356", email: "elifAydın@gmail.com", created_at: "14.10.2000", username: "elif_aydin", name: "Elif", surname: "Aydın", password: "123456", rating: 21, department: "Sociology"),
        .init(id: "12357", email: "canDemir@gmail.com", created_at: "15.10.2000", username: "can_demir", name: "Can", surname: "Demir", password: "123456", rating: 23, department: "Physics"),
        .init(id: "12358", email: "merveKorkmaz@gmail.com", created_at: "16.10.2000", username: "merve_korkmaz", name: "Merve", surname: "Korkmaz", password: "123456", rating: 25, department: "Marketing"),
        .init(id: "12359", email: "ahmetAydın@gmail.com", created_at: "17.10.2000", username: "ahmet_aydin", name: "Ahmet", surname: "Aydın", password: "123456", rating: 27, department: "Finance"),
        .init(id: "12360", email: "gamzeYilmaz@gmail.com", created_at: "18.10.2000", username: "gamze_yilmaz", name: "Gamze", surname: "Yılmaz", password: "123456", rating: 26, department: "Human Resources"),
        .init(id: "12361", email: "furkanArslan@gmail.com", created_at: "19.10.2000", username: "furkan_arslan", name: "Furkan", surname: "Arslan", password: "123456", rating: 29, department: "Environmental Science"),
        .init(id: "12362", email: "zeynepCetin@gmail.com", created_at: "20.10.2000", username: "zeynep_cetin", name: "Zeynep", surname: "Çetin", password: "123456", rating: 28, department: "Education"),
        .init(id: "12363", email: "keremGüneş@gmail.com", created_at: "21.10.2000", username: "kerem_gunes", name: "Kerem", surname: "Güneş", password: "123456", rating: 30, department: "Industrial Engineering"),
        .init(id: "12364", email: "denizKaya@gmail.com", created_at: "22.10.2000", username: "deniz_kaya", name: "Deniz", surname: "Kaya", password: "123456", rating: 32, department: "Architecture"),
        .init(id: "12365", email: "gülAydın@gmail.com", created_at: "23.10.2000", username: "gul_aydin", name: "Gül", surname: "Aydın", password: "123456", rating: 31, department: "International Relations"),
    ]
}

