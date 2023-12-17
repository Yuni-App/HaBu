//
//  protocol.swift
//  HaBu
//
//  Created by mert alp on 17.12.2023.
//

import Foundation

protocol AuthenticationProtocol {
    var isLoggedIn: Bool { get set }
    
    func login(username: String, password: String)
    func signin(username: String, password: String)
}
