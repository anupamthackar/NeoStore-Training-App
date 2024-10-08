//
//  UserData.swift
//  NeoStore Training App
//
//  Created by Neosoft on 18/07/24.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let roleId: Int
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let profilePic: String?
    let countryId: Int?
    let gender: String
    let phoneNo: String
    let dob: String?
    let isActive: Bool
    let created: String
    let modified: String
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case roleId = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case username
        case profilePic = "profile_pic"
        case countryId = "country_id"
        case gender
        case phoneNo = "phone_no"
        case dob
        case isActive = "is_active"
        case created
        case modified
        case accessToken = "access_token"
    }
}

