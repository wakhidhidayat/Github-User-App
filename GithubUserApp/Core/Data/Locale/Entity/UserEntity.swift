//
//  UserEntity.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RealmSwift

class UserEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var username: String = ""
    @objc dynamic var avatarUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
