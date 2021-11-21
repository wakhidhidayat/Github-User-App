//
//  DetailUserMapper.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

final class DetailUserMapper: NSObject {
    
    static func mapResponseToDomain(from userResponse: DetailUserResponse) -> DetailUserModel {
        return DetailUserModel(
            id: userResponse.id,
            username: userResponse.username,
            avatarUrl: userResponse.avatarUrl,
            name: userResponse.name,
            following: userResponse.following,
            followers: userResponse.followers,
            repos: userResponse.repos,
            location: userResponse.location,
            email: userResponse.email
        )
    }
    
}
