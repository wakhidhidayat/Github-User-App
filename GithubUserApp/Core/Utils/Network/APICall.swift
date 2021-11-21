//
//  APICall.swift
//  GithubUserApp
//
//  Created by Wahid Hidayat on 19/11/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import Foundation
import Alamofire

struct APICall {
    
    static let baseUrl = "https://api.github.com/"
    static let header: HTTPHeaders = ["Authorization": "token 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"]
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case users
        case detailUser(username: String)
        
        public var url: String {
            switch self {
            case .users:
                return "\(APICall.baseUrl)users"
            case .detailUser(username: let username):
                return "\(APICall.baseUrl)users/\(username)"
            }
        }
        
    }
    
}
