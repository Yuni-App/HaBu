//
//  NavigationStateManager.swift
//  HaBu
//
//  Created by OmerErbalta on 5.12.2023.
//

import Foundation

enum PathCases:Hashable {
    // Auth
    enum Auth :Hashable{
        case infoView
        case loginView
        enum Register :Hashable{
            case first
            case second
            case third
        }
    }
    // Feed
    enum Feed :Hashable{
        case feedCell
        case feedView
    }
    // Search
    enum Search :Hashable{
        case searchView
        case searchSecond
    }
    // Notification
    enum Notification :Hashable{
        case notification
        case likes
    }
    // AddPost
    case addPost
    
    // Settings
    enum Settings :Hashable{
        case settings
        case agreement
        case changePassword
        case changePasswordSuccess
        case deleteAccountPassword
        case deleteAccountCode
    }
    // Profile
    enum Profile :Hashable {
        case profile
        case editProfile
    }
    
    case tabbar
}


class NavigationStateManager : ObservableObject{
    @Published var path : [PathCases] = []
    @Published var selection : String = "Feed"
    
    func pop(_ selection:String? = nil){
        if !path.isEmpty{
            path.removeLast()
            self.selection = selection ?? self.selection
        }
    }
    func popToRoot(_ selection:String? = nil){
        if !path.isEmpty{
            path = [.tabbar]
            self.selection = selection ?? self.selection
        }
    }
    func popToNumber(number:Int){
        if number <= path.count{
            path.removeLast(number)
        }
    }
    func push(_ push:PathCases){
        path.append(push)
    }
    func pushArray(_ push:[PathCases]){
        path += push
    }
    
}
