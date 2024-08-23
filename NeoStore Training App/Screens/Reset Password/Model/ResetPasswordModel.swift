import Foundation


struct ResetPasswordRequest: Codable {
    let old_password: String?
    let password: String?
    let confirm_password: String?
}

struct ResetPasswordResponse: Codable {
    let status: String
    let data: [String]
    let message: String
    let user_msg: String
}
