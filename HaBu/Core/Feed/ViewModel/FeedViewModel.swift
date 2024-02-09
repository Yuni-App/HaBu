//
//  FeedViewModel.swift
//  HaBu
//
//  Created by OmerErbalta on 5.01.2024.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa
import SwiftUI

class FeedViewModel : ObservableObject{
    var postsData: PublishSubject<[Post]> = PublishSubject()
    private var listener: ListenerRegistration?
    var PostCount = 0
  @Published  var newPostCount = 0
    
    init() {
        Task{
          try await requestData()
            listenForChanges()
        }
    }
    
    func requestData() async throws {
        var postsFromService = await PostService().fetchPosts()
        print(postsFromService)

        PostCount = postsFromService.count
        for i in 0..<postsFromService.count {
            var user :User?
            do {
                user = try await UserService.fetchUser(withUserID: postsFromService[i].userId)
                postsFromService[i].user = user
            }
            catch{
                postsFromService[i].user = User.MockData[0]
            }
        }
        self.postsData.onNext(postsFromService)
    }
    
    func listenForChanges() {
           listener = Firestore.firestore().collection("post").addSnapshotListener{ [weak self] (snapshot, error) in
                   guard let documents = snapshot?.documents else {
                       print("Error fetching documents: \(error!)")
                       return
                   }
                   
                   let posts = documents.compactMap({try? $0.data(as:Post.self)})
               print(posts)
               
               DispatchQueue.main.async {
                   withAnimation {
                       self?.newPostCount = posts.count - self!.PostCount
                   }
               }
               }
           }
        
        deinit {
            listener?.remove()
        }
}
