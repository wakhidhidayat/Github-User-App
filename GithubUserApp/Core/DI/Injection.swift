//
//  Injection.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation

final class Injection: NSObject {
    
    private func provideRepository() -> UserRepositoryProtocol {
        let remote = RemoteDataSource.sharedInstance
        return UserRepository(remoteDataSource: remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }

}
