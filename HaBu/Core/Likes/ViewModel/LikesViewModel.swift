//
//  LikesViewModel.swift
//  HaBu
//
//  Created by mert alp on 22.12.2023.
//

import Foundation

class LikesViewModel: ObservableObject {
    @Published var likeUsersList :[User]  = []
 
    func fetchLikesUserList(userIdList : [String]){
        likeUsersList = [User.MockData[2]]
    }
}

