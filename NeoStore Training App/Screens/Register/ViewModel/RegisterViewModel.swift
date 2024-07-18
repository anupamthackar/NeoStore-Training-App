//
//  RegisterViewModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 18/07/24.
//

import Foundation

func registerUser () {
    
    APIManager.request(endpoint: EndPointItems.register,
                        modeltype: RegistrationResponse.self,
                        parameters: registerData,
                        headers: nil) { result in
        switch result {
        case .success(let response):
            self.showAlert(message: response.message, completion: {self.NavigateToLogin()})
        case .failure(let error):
            self.showAlert(message: "Registration failed: \(error.localizedDescription)")
        }
    }
}
