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
    static let sharedInstance: (RemoteDataSourceProtocol) -> UserRepository = { remote in
        return UserRepository(remoteDataSource: remote)
    }
    
    init(remoteDataSource: RemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
}

extension UserRepository: UserRepositoryProtocol {
    
    func getUsers(result: @escaping (Result<[UserModel], Error>) -> Void) {
        return remoteDataSource.getUsers { remoteResponse in
            switch remoteResponse {
            case .success(let userResponse):
                let userResult = UserMapper.mapToDomain(from: userResponse)
                return result(.success(userResult))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
}
