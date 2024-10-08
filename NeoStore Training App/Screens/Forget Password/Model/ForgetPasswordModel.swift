import Foundation

struct ForgetPasswordRequest: Codable {
    let email: String
}

struct ForgetPasswordResponse: Codable {
    let status: Int
    let message: String
    let userMassage: String
    
    enum codingKey: String, CodingKey {
        case status
        case message
        case userMessage = "user_msg"
    }
}
