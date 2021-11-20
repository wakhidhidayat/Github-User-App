//
//  HomeInteractor.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    
    func getUsers() -> Observable<[UserModel]>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: UserRepositoryProtocol
    
    required init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return repository.getUsers()
    }
    
}
