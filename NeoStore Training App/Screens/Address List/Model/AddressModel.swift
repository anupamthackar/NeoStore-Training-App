import Foundation

struct AddressRequest: Codable {
    let address: String
}

struct AddressResponse: Codable {
    let status: Int
    let message: String
    let user_msg: String
}


struct Address: Codable {
    let mainAddress:  String
    let town: String
    let city: String
    let state: String
    let zipcode: String
    let country: String
    var isSelected: Bool = false
}

