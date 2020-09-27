//
//  BackendAPI.swift
//  HHSuperAdmin
//
//  Created by StartupBuilder.INFO on 9/27/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class BackendAPI: ObservableObject {
    
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
    
    @Published var testStatus: TestStatus = .idle
    
    private init() {}
    
    func performStatusTestOnAPI(_ apiEndpoint: String, clientId: String, clientSecret: String, username: String, password: String) {
        testStatus = .testing
        
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
                                        self.testStatus = .failed(errorMessage: errorDescription)
                                    } else {
                                        self.testStatus = .pass
                                    }
                                }
                            case .failure(let error):
                                debugPrint(error)
                                self.testStatus = .failed(errorMessage: "Unknown Error")
                            }
                }
    }
}
