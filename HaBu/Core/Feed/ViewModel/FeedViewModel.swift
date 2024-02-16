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
        return postsFromService
    }

    
    func listenForChanges() {
        postService.listenForChanges { [weak self] posts in
                DispatchQueue.main.async {
                    withAnimation {
                        self?.newPostCount = posts.count
                    }
                }
            }
        }
        
        deinit {
            listener?.remove()
        }
}
