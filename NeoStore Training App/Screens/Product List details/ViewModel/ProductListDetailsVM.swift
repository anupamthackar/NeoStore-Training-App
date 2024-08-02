//
//  ProductListDetailsViewModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 31/07/24.
//

import Foundation

class ProductListDetailsVM {
    
    var productsDetails: ProductListDetailsResponse?
    
    func fatchProductsDetails(
        request: ProductListDetailsRequest,
        
        completion: @escaping((String?) -> Void)) {
    
    APIManager.shared.request(
        endpoint: EndPointItems.getProductDetails,
        modeltype: ProductListDetailsResponse.self,
        parameters: request) { response in
            switch response {
            case .success(let response):
                self.productsDetails = response
                completion(nil)
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
