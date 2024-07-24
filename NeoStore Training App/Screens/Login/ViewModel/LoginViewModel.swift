//
//  LoginViewModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 17/07/24.
//

import Foundation
import Alamofire


class LoginViewModel {
    
    var loginResponse: LogInResponse?
    
    func loginUser(with details: LoginRequest,completion: @escaping(Result<LogInResponse, Error>) -> Void) {
        
        APIManager.shared.request(endpoint: EndPointItems.login,
                                  modeltype: LogInResponse.self,
                                  parameters: details,
                                  headers: nil) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
