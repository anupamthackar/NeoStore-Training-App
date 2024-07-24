//
//  ForgetPasswordModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 24/07/24.
//

import Foundation

struct ForgetPasswordRequest {
    let email: String
}

struct ForgetPasswordResponse {
    let status: Int
    let message: String
    let userMassage: String
    
    enum codingKey: String, CodingKey {
        case status
        case message
        case userMessage = "user_msg"
    }
}
