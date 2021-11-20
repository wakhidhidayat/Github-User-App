//
//  UserRepository.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol {
    
    func getUsers(result: @escaping (Result<[UserModel], Error>) -> Void)
    
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
    
    func getUsers(result: @escaping (Result<[UserModel], Error>) -> Void) {
        localeDataSource.getUsers { localeReponse in
            switch localeReponse {
            case .success(let users):
                // if data local is empty, geting data from remote
                if users.isEmpty {
                    self.remoteDataSource.getUsers { remoteResponse in
                        switch remoteResponse {
                        case .success(let remoteUsers):
                            // mapping data from remote result to entity and insert to db
                            let usersEntity = UserMapper.mapUserResponseToEntity(from: remoteUsers)
                            self.localeDataSource.addUsers(from: usersEntity) { addState in
                                switch addState {
                                case .success(let isAddSuccess):
                                    if isAddSuccess {
                                        self.localeDataSource.getUsers { userLocaleResponse in
                                            switch userLocaleResponse {
                                            case .success(let usersListEntity):
                                                let resultList = UserMapper.mapUserEntityToDomain(from: usersListEntity)
                                                return result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    // if data is not empty geting data from local, map to domain
                    let usersList = UserMapper.mapUserEntityToDomain(from: users)
                    return result(.success(usersList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
