//
//  FeedViewModel.swift
//  HaBu
//
//  Created by OmerErbalta on 5.01.2024.
//

import Foundation
import Firebase

class FeedViewModel : ObservableObject{
    @Published var  posts : [Post] = []
    var snapShot: [DocumentSnapshot] =   []
    init() {
        Task{
            try await fetchPosts()
            await snapShotToPost()
        }
    }
    @MainActor
    func fetchPosts() async throws{
        var snapshot : [DocumentSnapshot] = []
        if  self.snapShot.count > 1 {
          if let lastDocument = snapshot.last{
              let data = try await Firestore.firestore().collection("post").order(by: "timeStap",descending: true).start(afterDocument: lastDocument).limit(to: 20).getDocuments()
              snapshot.append(contentsOf: data.documents)
          }
        }
        else{
            let data = try await Firestore.firestore().collection("post").order(by: "timeStamp",descending: true).limit(to: 20).getDocuments()
            snapshot = data.documents
        }
        self.snapShot.append(contentsOf:snapshot)
        
    }
    @MainActor
    func snapShotToPost(){
        let data  = self.snapShot.compactMap({try? $0.data(as:Post.self)})
        print(snapShot)
        posts.append(contentsOf: data)
        print(posts)
    }
}
