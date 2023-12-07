//
//  NavigationStateManager.swift
//  HaBu
//
//  Created by OmerErbalta on 5.12.2023.
//

import Foundation
import SwiftUI


enum PathCases: Hashable {
    case auth(Auth)
    case feed(Feed)
    case search(Search)
    case notification(Notification)
    case addPost
    case settings(Settings)
    case profile(Profile)
    case tabbar
    
    
    var view: any View {
        switch self {
        case .auth(let auth):
            switch auth {
            case .infoView:
                return InfoView()
            case .loginView:
                return LoginView()
            case .register(let register):
                switch register {
                case .first:
                    return RegisterBuildFirstView()
                case .second:
                    return RegisterBuildSecondView()
                case .third:
                    return RegisterBuildThirdView()
                }
            }
        case .feed(let feed):
            switch feed {
            case .feedCell:
                return FeedView()
            case .feedView:
                return FeedView()
            }
        case .search(let search):
            switch search {
            case .searchView:
                return SerachView()
            case .searchSecond:
                return SerachView()
            }
        case .notification(let notification):
            switch notification {
            case .notification:
                return NotificationView()
            case .likes:
                return TabbarView()
            }
        case .addPost:
            return AddPostView()
        case .settings(let settings):
            switch settings {
            case .settings:
                return SettingsView()
            case .agreement:
                return AgreementView()
            case .changePassword:
                return ChangePasswordView()
            case .changePasswordSuccess:
                return ChangePasswordSuccessView()
            case .deleteAccountPassword:
                return DeleteAccountCodeView()
            case .deleteAccountCode:
                return DeleteAccountCodeView()
            }
        case .profile(let profile):
            switch profile {
            case .profile:
                return TabbarView()
            case .editProfile:
                return TabbarView()
            }
        case .tabbar:
            return TabbarView()
        }
    }
}

extension PathCases {
    enum Auth: Hashable {
        case infoView
        case loginView
        case register(Register)
    }

    enum Register: Hashable {
        case first
        case second
        case third
    }

    enum Feed: Hashable {
        case feedCell
        case feedView
    }

    enum Search: Hashable {
        case searchView
        case searchSecond
    }

    enum Notification: Hashable {
        case notification
        case likes
    }

    enum Settings: Hashable {
        case settings
        case agreement
        case changePassword
        case changePasswordSuccess
        case deleteAccountPassword
        case deleteAccountCode
    }

    enum Profile: Hashable {
    
        case profile
        case editProfile
    }
}


class NavigationStateManager : ObservableObject{
    @Published var path : [PathCases] = []
    @Published var selection : String = "Feed"
    @Published var hideTabBar = false
    @Published var bottomEdge :CGFloat = 0
    @Published var topEdge: CGFloat = 0
    
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
        path.append(.addPost)
    }
    func pushArray(_ push:[PathCases]){
        path += push
    }
    
    func destinationWay(_ path:PathCases){
        
    }
}
