//
//  UsersMapper.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

final class UserMapper: NSObject {
    
    static func mapUserResponseToDomain(from userResponse: [UserResponse]) -> [UserModel] {
        return userResponse.map { result in
            return UserModel(id: result.id, username: result.username, avatarUrl: result.avatarUrl)
        }
    }
    
    static func mapUserResponseToEntity(from userResponse: [UserResponse]) -> [UserEntity] {
        return userResponse.map { result in
            let userEntity = UserEntity()
            userEntity.id = result.id
            userEntity.username = result.username
            userEntity.avatarUrl = result.avatarUrl
            return userEntity
        }
    }
    
    static func mapUserEntityToDomain(from userEntity: [UserEntity]) -> [UserModel] {
        return userEntity.map { result in
            return UserModel(id: result.id, username: result.username, avatarUrl: result.avatarUrl)
        }
    }
    
}
