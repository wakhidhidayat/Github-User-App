//
//  RemoteDataSource.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: class {
    
    func getUsers(result: @escaping (Result<[UserResponse], URLError>) -> Void)
    
}

final class RemoteDataSource: NSObject {
    
    static let sharedInstance = RemoteDataSource()
    
    private override init() { }
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getUsers(result: @escaping (Result<[UserResponse], URLError>) -> Void) {
        if let url = URL(string: Endpoints.Gets.users.url) {
            AF.request(url, headers: APICall.header)
                .validate()
                .responseDecodable(of: [UserResponse].self) { response in
                    switch response.result {
                    case .success(let users):
                        return result(.success(users))
                    case .failure(let error):
                        print(error)
                        return result(.failure(.invalidResponse))
                    }
                }
        }
    }
    
}
