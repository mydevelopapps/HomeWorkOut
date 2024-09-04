//
//  RegistrationModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 06/09/2023.
//

import Foundation


// Mark: - RegisterRequest
struct SignUp: Codable {
    let first_name: String?
    let last_name: String?
    let email: String?
    let password: String?
    let device_type: String?
    let device_id: String?
    let timezone: String?

}


// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let success, message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User
    let token: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName, lastName: String
    let userType: Int
    let profileImage: String
    let forgotPasswordCode: JSONNull?
    let email: String
    let emailVerifiedAt: JSONNull?
    let deviceType, deviceID,timezone : String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case userType = "user_type"
        case profileImage = "profile_image"
        case forgotPasswordCode = "forgot_password_code"
        case email
        case emailVerifiedAt = "email_verified_at"
        case deviceID = "device_id"
        case timezone
        case deviceType = "device_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
   
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
