import Foundation

struct EditCartRequest: Codable {
    let productId: Int
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case quantity
    }
}

struct EditCartResponse: Codable {
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
