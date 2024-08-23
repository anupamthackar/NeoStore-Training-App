import Foundation

struct ratingRequest: Codable {
    let productId: Int?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case rating
    }
}

// MARK: - Welcome
struct RatingResponse: Codable {
    let status: Int
    let data: DataClass
    let message, userMsg: String
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, productCategoryID: Int
    let name, producer, description: String
    let cost: Int
    let rating: Double
    let viewCount: Int
    let created, modified: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productCategoryID = "product_category_id"
        case name, producer, description, cost, rating
        case viewCount = "view_count"
        case created, modified
    }
}

//struct RatingResponse: Codable {
//    let status: Bool
//    let message: String?
//    let userMsg: String?
//
//    enum CodingKeys: String, CodingKey {
//        case status, message, userMsg = "user_msg"
//    }
//}

//struct ProductData : Codable{
//    let id: Int
//    let productCategoryId: Int
//    let name: String
//    let producer: String
//    let description: String
//    let cost: Int
//    let rating: Int
//    let viewCount: Int
//    let productImages: String?
//    let created: String
//    let modified: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, productCategoryId = "product_category_id", name, producer, description, cost, rating, viewCount = "view_count", productImages = "product_images", created, modified
//    }
//}

