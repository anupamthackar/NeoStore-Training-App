//
//  APIManager.swift
//  NeoStore Training App
//
//  Created by Neosoft on 17/07/24.
//

import Foundation

import Alamofire

class APIManager {
    // Singleton instance
    static let shared = APIManager()
    private init(){}
    
    //MARK: Generic Request Method
    func request<T: Codable, U: Codable> (endpoint: EndPointType,
                                          modeltype: T.Type,
                                          parameters: U?,
                                          headers: HTTPHeaders? = nil,
                                          completion: @escaping (Result<T, Error>) -> Void){
        
        let encoder: ParameterEncoder = endpoint.method == .post ? URLEncodedFormParameterEncoder.default : JSONParameterEncoder.default
        
        AF.request(endpoint.url!,
                   method: endpoint.method,
                   parameters: parameters,
                   encoder: encoder,
                   headers:  headers)
        .validate(statusCode: 200...299)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//    //MARK: Generic POST Method
//    func postCall<T: Codable, U: Codable>(url: String,
//                                          modelType: T.Type,
//                                          type: EndPointType,
//                                          parameters: U,
//                                          headers: HTTPHeaders?,
//                                          completion: @escaping (Result<T?, Error>) -> Void) {
//        AF.request(type.url!,
//                   method: .post,
//                   parameters: parameters,
//                   encoder: JSONParameterEncoder.default,
//                   headers: headers)
//        .validate(statusCode: 200...299)
//        .responseDecodable(of: T.self) { response in
//            switch response.result {
//            case .success(let data):
//                completion(.success(data))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    //MARK: Generic GET Request
//    func getGet<T: Codable> (url: String,
//                                 headers: HTTPHeaders?,
//                                 parameters: T,
//                                 completion: @escaping (Result<T, Error>) -> Void) {
//        AF.request(url, method: .get, headers: headers)
//            .validate(statusCode: 200...299)
//            .responseDecodable(of: T.self) { response in
//                switch response.result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
}
