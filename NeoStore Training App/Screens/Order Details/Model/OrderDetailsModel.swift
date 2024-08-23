import Foundation

struct OrderdetailRequest: Codable{
    let orderId: Int
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
    }
}

struct OrderDetailsResponse: Codable {
    let status: Int
    let data: DataC
}

struct DataC: Codable {
    let id, cost: Int
    let address: String
    let orderDetails: [OrderDetail]
    
    enum CodingKeys: String, CodingKey {
        case id, cost, address
        case orderDetails = "order_details"
    }
}

struct OrderDetail: Codable {
    let id, orderID, productID, quantity: Int
    let total: Int
    let prodName, prodCatName: String
    let prodImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case productID = "product_id"
        case quantity, total
        case prodName = "prod_name"
        case prodCatName = "prod_cat_name"
        case prodImage = "prod_image"
    }
}
