//
//  DetailUserResponse.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct DetailUserResponse: Decodable {
    
    let id: Int
    let username: String
    let avatarUrl: String
    let following: Int
    let followers: Int
    let repos: Int
    let location: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username = "login"
        case avatarUrl = "avatar_url"
        case following
        case followers
        case repos = "public_repos"
        case location
        case email
    }
    
}
