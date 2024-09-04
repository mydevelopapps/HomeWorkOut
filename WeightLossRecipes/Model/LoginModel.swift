//
//  LoginModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 13/09/2023.
//

import Foundation


// LoginRequest
struct LoginRequest:Encodable{
    
    let email: String?
    let password: String?
    let device_type: String?
    let device_id: String?
    let timezone: String?
}

struct LoginResponse: Decodable {
    let data: LoginDataClass
    let message: String?
    let success: String?
}

// MARK: - DataClass
struct LoginDataClass: Decodable {
    let token: String?
    let user: LoginUser
}

// MARK: - User
struct LoginUser: Decodable {
    let createdAt, deviceID, deviceType, email: String?
    let emailVerifiedAt: JSONNull?
    let firstName: String?
    let forgotPasswordCode: Int?
    let id: Int?
    let lastName, profileImage, timezone, updatedAt: String?
    let userType: Int

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case deviceID = "device_id"
        case deviceType = "device_type"
        case email
        case emailVerifiedAt = "email_verified_at"
        case firstName = "first_name"
        case forgotPasswordCode = "forgot_password_code"
        case id
        case lastName = "last_name"
        case profileImage = "profile_image"
        case timezone
        case updatedAt = "updated_at"
        case userType = "user_type"
    }
}


struct DeleteAccountRequest: Encodable{
    
    var password: String
}

struct DeleteAccountResponse: Decodable{
    
    var message: String?
    var success: String?
    
}
