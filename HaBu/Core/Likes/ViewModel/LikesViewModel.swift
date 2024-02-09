//
//  LikesViewModel.swift
//  HaBu
//
//  Created by mert alp on 22.12.2023.
//

import Foundation

class LikesViewModel: ObservableObject {
    @Published var likeUsersList :[User]  = []
 
    init(userListString:[String]){
        Task{
            for userId in userListString{
                do{
                    var user = try await UserService.fetchUser(withUserID: userId)
                    likeUsersList.append(user)
                }
                catch{
                    print(userId)
                }
            }
        }
    }
}

