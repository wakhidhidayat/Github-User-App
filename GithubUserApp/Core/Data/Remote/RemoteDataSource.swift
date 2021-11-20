//
//  RemoteDataSource.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getUsers() -> Observable<[UserResponse]>
    
}

final class RemoteDataSource: NSObject {
    
    static let sharedInstance = RemoteDataSource()
    
    private override init() { }
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getUsers() -> Observable<[UserResponse]> {
        return Observable<[UserResponse]>.create { observer in
            if let url = URL(string: Endpoints.Gets.users.url) {
                AF.request(url, headers: APICall.header)
                    .validate()
                    .responseDecodable(of: [UserResponse].self) { response in
                        switch response.result {
                        case .success(let users):
                            observer.onNext(users)
                            observer.onCompleted()
                        case .failure(let error):
                            print(error)
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
}
