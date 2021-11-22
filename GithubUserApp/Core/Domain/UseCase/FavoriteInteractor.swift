//
//  FavoriteInteractor.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 22/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    
    func getFavorites() -> Observable<[DetailUserModel]>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repo: UserRepositoryProtocol
    
    init(repo: UserRepositoryProtocol) {
        self.repo = repo
    }
    
    func getFavorites() -> Observable<[DetailUserModel]> {
        return repo.getFavorites()
    }
    
}
