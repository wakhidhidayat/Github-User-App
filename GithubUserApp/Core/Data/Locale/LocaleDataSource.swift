//
//  LocaleDataSource.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getUsers() -> Observable<[UserEntity]>
    func addUsers(from users: [UserEntity]) -> Observable<Bool>
    func addToFavorites(user: DetailUserEntity) -> Observable<Bool>
    
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
    
    func getUsers() -> Observable<[UserEntity]> {
        return Observable<[UserEntity]>.create { observer in
            if let realm = self.realm {
                let users: Results<UserEntity> = {
                    realm.objects(UserEntity.self).sorted(byKeyPath: "id", ascending: true)
                }()
                observer.onNext(users.toArray(ofType: UserEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addUsers(from users: [UserEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for user in users {
                            realm.add(user, update: .all)
                        }
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addToFavorites(user: DetailUserEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(user)
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
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
