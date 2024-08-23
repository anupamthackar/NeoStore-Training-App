import Foundation

struct ProductListDetailsRequest: Codable {
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
    }
}

struct ProductListDetailsResponse: Codable {
    let status: Int
    let data: ProductDetails?
}

struct ProductDetails: Codable {
    let id: Int
    let productCategoryId: Int
    let name: String
    let producer: String
    let description: String
    let cost: Double
    let rating: Double
    let viewCount: Int
    let created: String
    let modified: String
    let productImages: [ProductImage]?
    
    enum CodingKeys: String, CodingKey {
        case id, productCategoryId = "product_category_id", name, producer, description, cost, rating, viewCount = "view_count", productImages = "product_images", created, modified
    }
}

struct ProductImage: Codable {
    let id: Int
    let productId: Int
    let image: String
    let created: String
    let modified: String
    
    enum CodingKeys: String, CodingKey {
        case id, productId = "product_id", image, created, modified
    }
}
