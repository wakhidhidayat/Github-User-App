//
//  DetailUserEntity.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RealmSwift

class DetailUserEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var username: String = ""
    @objc dynamic var avatarUrl: String = ""
    @objc dynamic var following: Int = 0
    @objc dynamic var followers: Int = 0
    @objc dynamic var repos: Int = 0
    @objc dynamic var location: String? = "Unknown"
    @objc dynamic var email: String? = "Unknown"
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
