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
    var name : String
    var surname : String
    var password : String
    var profileImageUrl : [String]?
    var bio : String?
    var rating : Float
    let department : String
    let register_year: String
    let anonimId : String
    var fcm : String? = ""
    var keywordsForLookup: [String]  {
          [self.username.generateStringSequence(), self.name.generateStringSequence(), self.surname.generateStringSequence(), "\(self.name) \(self.surname)".generateStringSequence()].flatMap { $0 }
      }
}
extension User {
    static var MockData: [User] = [
        .init(id: "DuZ0Jo1m7sOnARgym09ZP0Yv7i22", email: "erbalta80@gmail.com", created_at: "03.10.2000", username: "omer_erbalta", name: "Hata", surname: "!!!!", password: "123456", bio: "Senior Swift Developer Aynı Zamanda YUNİ de patron,ceo,takım lideri,yatırımcı,yüzde 98 hisse sahibi,yusufun ve mertin sahibi", rating: 90, department: "Computer Science",register_year: "2020",anonimId: "user1234"),
        
    ]
}

/*
// enum FacultyCode: String {
 case computerScience = "1370"
 case electricalEngineering = "1371"
 case mechanicalEngineering = "1372"
 
 // Fakülte kodlarına karşılık gelen isimleri döndüren hesaplanmış özellik
 var name: String {
     switch self {
     case .computerScience:
         return "Computer Science"
     case .electricalEngineering:
         return "Electrical Engineering"
     case .mechanicalEngineering:
         return "Mechanical Engineering"
     }
 }
}

// E-posta adresinden @ işaretinden önceki 12 sayıyı sınıflandıran bir fonksiyon.
func classifyIDFromEmail() -> String? {
 // E-posta adresini "@" işaretine göre ayırır.
 let components = email.components(separatedBy: "@")
 // Eğer iki bileşen varsa, ilk bileşeni alırız (kullanıcı adı) ve istenen 12 sayıyı alırız.
 if components.count == 2 {
     let idCandidate = components[0]
     // İlgili parçaları ayırırız.
     let year = idCandidate.prefix(4)
     let facultyCodeString = idCandidate.dropFirst(4).prefix(4)
     let departmentCode = idCandidate.dropFirst(8).prefix(1)
     let sequenceNumber = idCandidate.dropFirst(9)
     // Fakülte kodunu fakülte ismiyle değiştiririz.
     if let facultyCode = FacultyCode(rawValue: String(facultyCodeString)) {
         // Sınıflandırmayı oluştururuz.
         let classification = "\(year) \(facultyCode.name) \(departmentCode) \(sequenceNumber)"
         return classification
     }
 }
 return nil
}
*/
