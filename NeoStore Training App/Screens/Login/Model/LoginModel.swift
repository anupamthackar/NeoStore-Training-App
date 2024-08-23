import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}


struct LogInResponse: Codable {
    let status: Int
    let data: UserData?
    let message: String
    let userMessage: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
        case userMessage = "user_msg"
    }
}
