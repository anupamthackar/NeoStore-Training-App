//
//  ForgetPasswordViewModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 24/07/24.
//

import Foundation

class ForgetPasswordViewModel {
    
    var forgetPasswordStatus: ((DataBinding<ForgetPasswordResponse>) -> Void)?
    
    func forgetPassword(email: String){
        forgetPasswordStatus?(.loading)
        
        let forgetPasswordRequest = ForgetPasswordRequest(email: email)
        
        APIManager.shared.request(endpoint: EndPointItems.forgetPassword,
                                  modeltype: ForgetPasswordResponse.self,
                                  parameters: forgetPasswordRequest){ response in
            switch response {
            case .success(let result):
                self.forgetPasswordStatus?(.success(result))
            case .failure(let error):
                self.forgetPasswordStatus?(.failure(error))
            }
        }
    }
}

