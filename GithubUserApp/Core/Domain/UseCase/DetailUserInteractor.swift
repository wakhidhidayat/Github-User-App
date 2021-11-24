//
//  DetailUserInteractor.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailUserUseCase {
    
    func getDetailUser(username: String) -> Observable<DetailUserModel>
    func addToFavorites(user: DetailUserModel) -> Observable<Bool>
    func deleteUser(user: DetailUserModel) -> Observable<Bool>
    
}

class DetailUserInteractor: DetailUserUseCase {
    
    private let repository: UserRepositoryProtocol
    
    required init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailUser(username: String) -> Observable<DetailUserModel> {
        return repository.getDetailUser(username: username)
    }
    
    func addToFavorites(user: DetailUserModel) -> Observable<Bool> {
        return repository.addToFavorites(user: user)
    }
    
    func deleteUser(user: DetailUserModel) -> Observable<Bool> {
        return repository.deleteUser(user: user)
    }
    
}
