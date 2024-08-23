import Foundation

struct UpdateAccountRequest: Codable {
    let first_name: String?
    let last_name: String?
    let email: String?
    let dob: String?
    let profile_pic: String?
    let phone_no: String?
}

struct UpdateAccountResponse: Codable {
    let status: Int
    let data: [String]
    let message: String
    let user_msg: String
}
