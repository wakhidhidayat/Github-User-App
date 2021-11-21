//
//  DetailUserPresenter.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 21/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailUserPresenterProtocol {
    
    func getDetailUser(username: String) -> Observable<DetailUserModel>
    
}

class DetailUserPresenter: DetailUserPresenterProtocol {
    
    let useCase: DetailUserUseCase
    
    init(useCase: DetailUserUseCase) {
        self.useCase = useCase
    }
    
    func getDetailUser(username: String) -> Observable<DetailUserModel> {
        return useCase.getDetailUser(username: username)
    }
    
}
