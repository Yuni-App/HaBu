//
//  Commnet.swift
//  HaBu
//
//  Created by yusuf on 14.11.2023.
//

import Foundation

struct Comment: Identifiable, Codable{
    let id: String
    let comment: String
    let userId: String
}
