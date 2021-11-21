//
//  HomePresenter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePresenterProtocol {
    
    func getUsers() -> Observable<[UserModel]>
    
}

class HomePresenter: HomePresenterProtocol {
    
    let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return useCase.getUsers()
    }
}
