//
//  BlockedUsersViewModal.swift
//  HaBu
//
//  Created by mert alp on 20.12.2023.
//

import Foundation
class BlockedUsersViewModal : ObservableObject{
    @Published var blockedList : [User] = []
    
    func fetchBlockedList(){
        blockedList =  [User.MockData[0]]
    }
}
