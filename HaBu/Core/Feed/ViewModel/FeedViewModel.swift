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
           await requestData()
            listenForChanges()
        }
    }
    
    func requestData() async{
        let postsFromService = await PostService().fetchPosts()
        PostCount = postsFromService.count
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
