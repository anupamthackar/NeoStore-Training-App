import Foundation


//struct OrderListResponse: Codable{
//    let status: Int
//    let data: [OrderListData]
//    let message: String
//    let user_msg: String
//}
//
//struct OrderListData: Codable {
//    let id: Int
//    let cost: Int
//    let created: Int
//}

struct OrderListResponse: Codable {
    let status: Int
    let data: [OrderListData]
    let message, userMsg: String
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

struct OrderListData: Codable {
    let id, cost: Int
    let created: String
}
