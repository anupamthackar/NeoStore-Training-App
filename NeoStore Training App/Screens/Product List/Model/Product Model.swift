import Foundation

struct ProductRequest: Codable {
    let product_category_id: Int
    let limit: Int?
    let page: Int?
}

struct Product: Codable {
    let id: Int
    let productCategoryId: Int
    let name: String
    let producer: String
    let description: String
    let cost: Double
    let rating: Double
    let viewCount: Int
    let productImages: String?
    let created: String
    let modified: String
    
    enum CodingKeys: String, CodingKey {
        case id, productCategoryId = "product_category_id", name, producer, description, cost, rating, viewCount = "view_count", productImages = "product_images", created, modified
    }
}

struct ProductResponse: Codable {
    let status: Int
    let data: [Product]
}
