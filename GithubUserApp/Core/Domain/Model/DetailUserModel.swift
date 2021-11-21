//
//  DetailUserModel.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

struct DetailUserModel: Equatable, Identifiable {
    
    let id: Int
    let username: String
    let avatarUrl: String
    let name: String?
    let following: Int
    let followers: Int
    let repos: Int
    let location: String?
    let email: String?
    
}
