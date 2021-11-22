//
//  Injection.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> UserRepositoryProtocol {
        let remote = RemoteDataSource.sharedInstance
        let realm = try? Realm()
        let locale = LocaleDataSource.sharedInstance(realm)
        return UserRepository(remoteDataSource: remote, localeDataSource: locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetailUser() -> DetailUserUseCase {
        let repository = provideRepository()
        return DetailUserInteractor(repository: repository)
    }
    
    func provideFavorites() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repo: repository)
    }

}
