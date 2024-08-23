import Foundation

struct RegistrationRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let confirmPassword: String
    let gender: String
    let phoneNo: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
        case confirmPassword = "confirm_password"
        case gender
        case phoneNo = "phone_no"
    }
}

struct RegistrationResponse: Codable {
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

