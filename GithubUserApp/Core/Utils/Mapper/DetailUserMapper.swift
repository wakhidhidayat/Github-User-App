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
            following: userResponse.following,
            followers: userResponse.followers,
            repos: userResponse.repos,
            location: userResponse.location,
            email: userResponse.email
        )
    }
    
    static func mapDomainToEntity(from userModel: DetailUserModel) -> DetailUserEntity {
        let user = DetailUserEntity()
        user.id = userModel.id
        user.username = userModel.username
        user.avatarUrl = userModel.avatarUrl
        user.following = userModel.following
        user.followers = userModel.followers
        user.repos = userModel.repos
        user.location = userModel.location
        user.email = userModel.email
        return user
    }
    
    static func mapArrayEntityToDomain(from usersEntity: [DetailUserEntity]) -> [DetailUserModel] {
        return usersEntity.map { result in
            return DetailUserModel(
                id: result.id,
                username: result.username,
                avatarUrl: result.avatarUrl,
                following: result.following,
                followers: result.followers,
                repos: result.repos,
                location: result.location,
                email: result.email
            )
        }
    }
    
}
