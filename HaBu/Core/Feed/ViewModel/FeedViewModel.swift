import Foundation
import Firebase
import RxSwift
import RxCocoa
import SwiftUI

@MainActor
class FeedViewModel : ObservableObject{
    var postsData: PublishSubject<[Post]> = PublishSubject()
    private var listener: ListenerRegistration?
    @Published  var newPostCount = 0
    @Published var lastPostFromFirebase : Post?
    @Published var postCount = 0
    @Published var tags = [String]()
    @Published var selectedFilter = "Hepsi"
    var postService = PostService()
    
    init() {
        Task {
            try await requestData()
            listenForChanges()
        }
    }
   
    
    func requestData() async throws  -> [Post]{
        var postsFromService = await postService.fetchPosts(tags: tags,postType: selectedFilter)
        for i in (postCount)..<postsFromService.count {
            var user: User?
            do {
                user = try await UserService.fetchUser(withUserID: postsFromService[i].userId)
                postsFromService[i].user = user
            } catch {
                postsFromService[i].user = User.MockData[0]
            }
        }
        self.postsData.onNext(postsFromService)
        self.lastPostFromFirebase = postsFromService[0]

        return postsFromService
    }

    
    func listenForChanges() {
        postService.listenForChanges { [weak self] posts in
                DispatchQueue.main.async {
                    withAnimation{
                        if let lastPost = self?.lastPostFromFirebase{
                            print(lastPost)
                            let indexOfLastPost = posts.firstIndex(where: {$0.id == lastPost.id})
                            self?.newPostCount = indexOfLastPost!

                        }
                    }
                }
            }
        }
        
        deinit {
            listener?.remove()
        }
}







