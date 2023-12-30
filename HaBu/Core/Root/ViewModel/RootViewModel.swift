//
//  RootViewModel.swift
//  HaBu
//
//  Created by OmerErbalta on 30.12.2023.
//


import Foundation
import Firebase
import Combine
@MainActor
class RootViewModel : ObservableObject{
    private let service = AuthService.shared
    private var cansellables = Set<AnyCancellable>()
    @Published var currentUser : User?
    @Published var userSession : FirebaseAuth.User?
    init(){
        Task{
            try await  setupSubscribers()
        }
    }

     func setupSubscribers() async throws{
        service.$userSession.sink { [weak self] userSession  in
            self?.userSession = userSession
        }.store(in: &cansellables)
        
        service.$currentUser.sink { [weak self] currentUser  in
            DispatchQueue.main.async {
                self?.currentUser = currentUser
            }
            
        }.store(in: &cansellables)
    }
    
}
