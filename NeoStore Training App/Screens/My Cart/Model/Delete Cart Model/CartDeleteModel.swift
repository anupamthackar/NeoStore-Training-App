import Foundation

struct DeleteCartRequest: Codable {
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
    }
}

struct DeleteCartResponse: Codable {
    let status: Int
    let data: Bool
    let totalCarts: Int    //  <--Check it
    let message: String
    let userMsg: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
        case userMsg = "user_msg"
        case totalCarts = "total_carts"
    }
}
