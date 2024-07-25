//
//  EndPointItems.swift
//  NeoStore Training App
//
//  Created by Neosoft on 17/07/24.
//

import Foundation
import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    
}

protocol EndPointType {
    var path: String {get}
    var baseURL: String {get}
    var url: URL? {get}
    var method: HTTPMethod {get}
}

enum EndPointItems {
    case register
    case login
    case forgetPassword
}

extension EndPointItems:  EndPointType {
    //End Path
    var path: String {
        switch self {
        case .login:
            return "users/login"
        case .register:
            return "users/register"
        case .forgetPassword:
            return "users/forgot"
        }
    }
    //Method
    var method: Alamofire.HTTPMethod {
        switch self {
        case .register, .login, .forgetPassword:
            return .post
        }
    }
    //Base URL
    var baseURL: String {
        return "http://staging.php-dev.in:8844/trainingapp/api/"
    }
    
    //Main URL
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    

}


