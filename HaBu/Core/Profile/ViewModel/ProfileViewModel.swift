//
//  ProfileViewModel.swift
//  HaBu
//
//  Created by OmerErbalta on 21.12.2023.
//

import Foundation
import UIKit

class ProfileViewModel:ObservableObject{
    init(user:User) {
        self.user = user
    }
    @Published var user:User
    @Published var editButtonPosition = CGPoint(x:Const.width, y : Const.height / 5)
    @Published private var shouldNavigate = false
    @Published var offset:CGFloat = 0
    @Published var lastOffset:CGFloat = 0
    @Published var TollBarOffset : CGFloat = 0
    @Published var topEdge:CGFloat = Const.height * 0.03
    let maxHeight = UIScreen.main.bounds.height / 2.7
    @Published var imageCount = 0
}
