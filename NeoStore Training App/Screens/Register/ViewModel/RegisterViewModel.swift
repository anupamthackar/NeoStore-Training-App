//
//  RegisterViewModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 18/07/24.
//

import Foundation
class RegisterViewModel {
    var registrationResponse: RegistrationResponse?
    
    func registerUser (with details: RegistrationRequest, completion: @escaping (Result <RegistrationResponse, Error>) -> Void) {
        
        APIManager.shared.request(endpoint: EndPointItems.register,
                                  modeltype: RegistrationResponse.self,
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
