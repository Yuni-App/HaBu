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

class FeedViewModel : ObservableObject{
    var postsData: PublishSubject<[Post]> = PublishSubject()
    private var listener: ListenerRegistration?

    
    init() {
        Task{
           await requestData()
            listenForChanges()
        }
    }
    
    func requestData() async{
        let postsFromService = await PostService().fetchPosts()
        self.postsData.onNext(postsFromService)
    }
    
    private func listenForChanges() {
        listener = Firestore.firestore().collection("post").addSnapshotListener{ [weak self] (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                let posts = documents.compactMap({try? $0.data(as:Post.self)})
                self?.postsData.onNext(posts)
            }
        }
        
        deinit {
            listener?.remove()
        }
}
