//
//  UserModel.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct UserModel: Equatable, Identifiable {
    
    let id: Int
    let username: String
    let avatarUrl: String
    
}
