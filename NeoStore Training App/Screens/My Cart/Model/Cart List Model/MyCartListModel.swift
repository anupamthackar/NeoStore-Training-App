import Foundation

struct CartListResponse: Codable {
    let status: Int
    let data: [CartItem]?
    let count: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case count
        case total
    }
}

struct CartItem: Codable {
    let id: Int
    let productId: Int
    var quantity: Int
    let product: ProductCartData

    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case quantity
        case product
    }
}

struct ProductCartData: Codable {
    let id: Int
    let name: String
    let cost: Int
    let productCategory: String
    let productImages: String?
    let subTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cost
        case productCategory = "product_category"
        case productImages = "product_images"
        case subTotal = "sub_total"
    }
}

struct EmptyModel: Codable{
    //When there is no perameter
}
