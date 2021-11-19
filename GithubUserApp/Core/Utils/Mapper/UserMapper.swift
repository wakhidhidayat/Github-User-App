//
//  UsersMapper.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

final class UserMapper: NSObject {
    
    static func mapToDomain(from userResponse: [UserResponse]) -> [UserModel] {
        return userResponse.map { result in
            return UserModel(id: result.id, username: result.username, avatarUrl: result.avatarUrl)
        }
    }
    
}
