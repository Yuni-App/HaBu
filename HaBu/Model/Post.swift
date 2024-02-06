//
//  Post.swift
//  HaBu
//
//  Created by yusuf on 14.11.2023.
//

import Foundation



struct Post : Identifiable,Codable,Hashable{
    let id : String
    let userId : String
    let caption : String
    var imageUrl : [String]?
    let timeStamp : String
    let likeList : [String]
    let isAnonim : Bool
    let isAnonimComment : Bool
    let tags :[String]
}
extension Post {
    static var MockData: [Post] = [
        .init(id: "0", userId: "0", caption: "Mert, sadece bir geliştirici değil, aynı zamanda olağanüstü bir karaktere sahip. Kod yazma yeteneği sadece başarılarına değil, aynı zamanda etrafındaki insanlara ilham kaynağı olmasına da olanak tanıyor.", imageUrl: ["https://developer.apple.com/swift/images/swift-og.png"], timeStamp: "01.01.2022", likeList: ["2"], isAnonim: false, isAnonimComment: false, tags: []),
        .init(id: "1", userId: "1", caption: "Mert, içten ve nezaketle dolu bir kişiliktir. Onun etrafında, insanların hemen fark edeceği samimi bir sıcaklık vardır. Başkalarına karşı duyarlılığı ve yardımseverliğiyle tanınır.", timeStamp: "02.02.2022", likeList: [], isAnonim: false, isAnonimComment: false, tags: []),
        // Diğer postları buraya kısaltarak ekle
    ]
}
/*
 struct Post: Identifiable, Decodable, Encodable {
   var id: String
   var title: String
   var content: String
   var likes: Int
   var likedBy: [String]
//like'ı benzersiz bir yapıya çevirmek için var bu sayede bir defa tıklanabilecek

   init(id: String, title: String, content: String, likes: Int) {
     self.id = id
     self.title = title
     self.content = content
     self.likes = likes
   }
//kullanıcının bir kez beğenebilmesine dayalı bir func
   func like() {
 if let user = Auth.auth().currentUser {
   if !likedBy.contains(user.uid) {
     self.likes += 1
     self.likedBy.append(user.uid)
     save()
   }
 }
}

   func getLikes() -> Int {
     return self.likes
   }

   func save() {
     Firestore.firestore().collection("posts").document(id).setData(self.toAnyObject()) { error in
       if let error = error {
         print(error)
       }
     }
   }
 }
 */


/*
 
 
 how many posts to show on the screen
 
 
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewModel: ObservableObject{
    @Published var documents: [DocumentSnapShot] = []
    let db = Firestore.firestore()
    
   //burada n sayısı ekranda kaç tane göstermek istiyoruz onu belirtmek için kullanıyoruz
   //30 tane yazarsak ekranda 30 tane gösterecek bu sayıyla değiştiriyoruz
    func loadPosts(amount n : Int ){
        var  query :Query
        if documents.count > 0{
            query = db.collection("posts").order(by: "createdTime", descending: true)
                .limit(to: n)
                .start(afterDocument: documents.last)
        }else{
            query = db.collection("posts").order(by: "createdTime", descending: true)
                .limit(to: n)
        }
        query.getDocuments{ querySnapshot, error in
            guard let documents = querySnapshot?.documents, error == nil else{
                print("error load posts \(error)")
                return
            }
            self.documents += documents
            
        }
    }
    func loadPostNeeded(current: DocumentSnapshot, amount n: Int){
        guard documents.count > 0 && current == documents.last! else{ return }
        self.loadPosts(amount: n)
    }
    
}
 
*/

 
 

