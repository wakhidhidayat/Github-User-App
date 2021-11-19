//
//  HomePresenter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void)
    
}

class HomePresenter: HomePresenterProtocol {
    
    let useCase: HomeUseCase
    var users = [UserModel]()
    var errorMessage = ""
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        return useCase.getUsers { result in
            completion(result)
        }
    }
}
