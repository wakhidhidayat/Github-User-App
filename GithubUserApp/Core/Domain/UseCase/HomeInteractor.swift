//
//  HomeInteractor.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

protocol HomeUseCase {
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void)
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: UserRepositoryProtocol
    
    required init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        return repository.getUsers { result in
            completion(result)
        }
    }
    
}
