//
//  LocaleDataSource.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getUsers(result: @escaping (Result<[UserEntity], DatabaseError>) -> Void)
    func addUsers(from users: [UserEntity], result: @escaping (Result<Bool, DatabaseError>) -> Void)
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmParam in
        return LocaleDataSource(realm: realmParam)
    }
    
    private init(realm: Realm?) {
        self.realm = realm
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getUsers(result: @escaping (Result<[UserEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let users: Results<UserEntity> = {
                realm.objects(UserEntity.self).sorted(byKeyPath: "id", ascending: true)
            }()
            result(.success(users.toArray(ofType: UserEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addUsers(from users: [UserEntity], result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for user in users {
                        realm.add(user, update: .all)
                    }
                }
                result(.success(true))
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
