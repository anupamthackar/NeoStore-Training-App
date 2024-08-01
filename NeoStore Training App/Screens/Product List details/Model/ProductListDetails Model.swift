//
//  ProductListDetailsModel.swift
//  NeoStore Training App
//
//  Created by Neosoft on 31/07/24.
//

import Foundation

struct ProductListDetailsRequest {
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = product_id
    }

}
