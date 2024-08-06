//
//  MyCartViewModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 05/08/24.
//

import Foundation
class ListCartViewModel {
    
    //MARK: List Cart VM
    var cartList: CartListResponse?
    
    func fetchCartItems(completion: @escaping ((Result<CartListResponse, Error>) -> Void)) {
        APIManager.shared.request(
            endpoint: EndPointItems.getCart,
            modeltype: CartListResponse.self,
            parameters: EmptyModel()) { response in
                switch response {
                case .success(let response):
                    self.cartList = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

class EditCartViewModel {
    var editCartResponse: EditCartResponse?
    
    func editCart(with request: EditCartRequest, completion: @escaping (Result<EditCartResponse, Error>) -> Void) {
        APIManager.shared.request(
            endpoint: EndPointItems.editCart,
            modeltype: EditCartResponse.self,
            parameters: request) { result in
                switch result {
                case .success(let response):
                    self.editCartResponse = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

class DeleteCartViewModel {
    var deleteCartResponse: DeleteCartResponse?
    
    func deleteCart(with request: DeleteCartRequest, completion: @escaping (Result<DeleteCartResponse, Error>) -> Void) {
        APIManager.shared.request(
            endpoint: EndPointItems.deleteCart,
            modeltype: DeleteCartResponse.self,
            parameters: request) { result in
                switch result {
                case .success(let response):
                    self.deleteCartResponse = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

