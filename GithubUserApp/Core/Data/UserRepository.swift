//
//  UserRepository.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    
    func getUsers() -> Observable<[UserModel]>
    func getDetailUser(username: String) -> Observable<DetailUserModel>
    func addToFavorites(user: DetailUserModel) -> Observable<Bool>
    
}

final class UserRepository: NSObject {
    
    private let remoteDataSource: RemoteDataSourceProtocol
    private let localeDataSource: LocaleDataSourceProtocol
    
    static let sharedInstance: (
        RemoteDataSourceProtocol, LocaleDataSourceProtocol
    ) -> UserRepository = { remote, locale in
        return UserRepository(remoteDataSource: remote, localeDataSource: locale)
    }
    
    init(remoteDataSource: RemoteDataSourceProtocol, localeDataSource: LocaleDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }
    
}

extension UserRepository: UserRepositoryProtocol {
    
    func getUsers() -> Observable<[UserModel]> {
        return self.localeDataSource.getUsers()
            .map { UserMapper.mapUserEntityToDomain(from: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remoteDataSource.getUsers()
                        .map { UserMapper.mapUserResponseToEntity(from: $0) }
                        .flatMap { self.localeDataSource.addUsers(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.localeDataSource.getUsers()
                            .map { UserMapper.mapUserEntityToDomain(from: $0) }
                        }
            )
    }
    
    func getDetailUser(username: String) -> Observable<DetailUserModel> {
        return remoteDataSource.getDetailUser(username: username)
            .map { DetailUserMapper.mapResponseToDomain(from: $0) }
    }
    
    func addToFavorites(user: DetailUserModel) -> Observable<Bool> {
        return self.localeDataSource.addToFavorites(user: DetailUserMapper.mapDomainToEntity(from: user))
    }
    
}
