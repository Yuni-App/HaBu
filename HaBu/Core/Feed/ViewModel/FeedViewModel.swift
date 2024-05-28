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
    @Published var posts = [Post]()
    var postService = PostService()
    
    init() {
        Task {
          _ =   try await requestData(pagination: false)
            listenForChanges()
        }
    }
   
    func pagination() async throws {
      _ =  try await requestData(pagination: true)
    }
    func requestData(pagination : Bool = false) async throws  -> [Post]{
        var postsFromService = await postService.fetchPosts(tags: tags,postType: selectedFilter,pagination:pagination)
        for i in (postCount)..<postsFromService.count {
            var user: User?
            do {
                user = try await UserService.fetchUser(withUserID: postsFromService[i].userId)
                postsFromService[i].user = user
            } catch {
                postsFromService[i].user = User.MockData[0]
            }
        }
        posts.append(contentsOf: postsFromService)
        self.postsData.onNext(posts)
        if postsFromService.count > 1{
            self.lastPostFromFirebase = postsFromService[0]

        }
        self.newPostCount = 0
        return postsFromService
    }

    
    func listenForChanges() {
        listener?.remove()
        listener = postService.listenForChanges { [weak self] posts in
            DispatchQueue.main.async {
                withAnimation {
                    if let lastPost = self?.lastPostFromFirebase {
                        let indexOfLastPost = posts.firstIndex(where: { $0.id == lastPost.id })
                        self?.newPostCount = indexOfLastPost ?? 0
                    }
                }
            }
        }
    }
   
}







