//
//  FavoritePresenter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 22/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoritePresenterProtocol {
    
    func getFavorites() -> Observable<[DetailUserModel]>
    
}

class FavoritePresenter: FavoritePresenterProtocol {
    
    let useCase: FavoriteUseCase
    
    init(useCase: FavoriteUseCase) {
        self.useCase = useCase
    }
    
    func getFavorites() -> Observable<[DetailUserModel]> {
        return useCase.getFavorites()
    }
    
}
