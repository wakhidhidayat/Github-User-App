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
    
    private static var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "APIToken-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'APIToken-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_TOKEN") as? String else {
            fatalError("Couldn't find key 'API_Token' in 'APITOKEN-Info.plist'.")
        }
        return value
    }
    
    static let baseUrl = "https://api.github.com/"
    static let header: HTTPHeaders = ["Authorization": "token \(apiKey)"]
    
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
