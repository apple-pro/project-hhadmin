//
//  BackendAPI.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/27/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class BackendAPI {
    
    static let shared = BackendAPI()
    
    enum TestStatus {
        case idle, testing, failed(errorMessage: String), pass
        
        var display: String {
            switch self {
            case .testing:
                return "Ongoing Testing"
            case .failed(let errorMessage):
                return "Failed - \(errorMessage)"
            case .pass:
                return "OK"
            default:
                return "Idle"
            }
        }
    }
    
    private var config = ConfigurationManager.shared
    private var accessToken: String?
    
    private init() {}
    
    func performStatusTestOnAPI(_ apiEndpoint: String, clientId: String, clientSecret: String, username: String, password: String, completionHandler: @escaping (TestStatus) -> Void) {
        
        let loginURL = "\(apiEndpoint)/oauth/token"
        
        let headers: HTTPHeaders = [
            .authorization(username: clientId, password: clientSecret),
            .contentType("application/x-www-form-urlencoded")
        ]
        
        let parameters = [
            "grant_type": "password",
            "scope": "any",
            "username": username,
            "password": password
        ]
        
        AF.request(loginURL, method: .post,
                   parameters: parameters,
                   headers: headers).responseJSON { response in
                    
                    switch response.result {
                    case .success(let result):
                        if let json = result as? NSDictionary {
                            if let errorDescription = json["error_description"] as? String {
                                completionHandler(.failed(errorMessage: errorDescription))
                            } else {
                                completionHandler(.pass)
                            }
                        }
                    case .failure(let error):
                        debugPrint(error)
                        completionHandler(.failed(errorMessage: "Unknown Error"))
                    }
                   }
    }
    
    func loginThen(_ action: @escaping () -> Void) {
        
        //TODO: check if access token is still valid
        if accessToken != nil {
            action()
            return
        }
        
        let loginURL = "\(config.apiEndpoint!)/oauth/token"
        let clientId = config.clientId!
        let clientSecret = config.clientSecret!
        let username = config.username!
        let password = config.password!
        
        let headers: HTTPHeaders = [
            .authorization(username: clientId, password: clientSecret),
            .contentType("application/x-www-form-urlencoded")
        ]
        
        let parameters = [
            "grant_type": "password",
            "scope": "any",
            "username": username,
            "password": password
        ]
        
        AF.request(loginURL, method: .post,
                   parameters: parameters,
                   headers: headers).responseJSON { response in
                    
                    switch response.result {
                    case .success(let result):
                        if let json = result as? NSDictionary {
                            if let accessToken = json["access_token"] as? String {
                                self.accessToken = accessToken
                            }
                        }
                    case .failure(let error):
                        debugPrint(error)
                        self.accessToken = nil
                    }
                    
                    action()
                   }
    }
    
    func fetch<T: Decodable>(_ resource: String, onCompletion completionHandler: @escaping (T) -> Void) {
        let listCompanyAccountsUrl = "\(config.apiEndpoint!)/api/\(resource)"
        
        let fetchResource = {
            if let activeAccessToken = self.accessToken {
                let headers: HTTPHeaders = [
                    .authorization(bearerToken: activeAccessToken)
                ]
                
                AF.request(listCompanyAccountsUrl, headers: headers).responseJSON { response in
                    
                    switch response.result {
                    case .success(let result):
                        let json = JSON(result)
                        let decoder = JSONDecoder()
                        if let results = try? decoder.decode(T.self, from: json["_embedded"][resource].rawData()) {
                            completionHandler(results)
                        }
                    case .failure(let error):
                        debugPrint(error)
                    }
                }
            }
        }
        
        loginThen {
            fetchResource()
        }
    }
    
}
