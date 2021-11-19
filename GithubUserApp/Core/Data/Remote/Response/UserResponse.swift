//
//  UserResponse.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    
    let id: Int
    let username: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case avatarUrl = "avatar_url"
    }
    
}
