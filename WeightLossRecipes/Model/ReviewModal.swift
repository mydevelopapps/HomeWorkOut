//
//  ReviewModal.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 07/10/2023.
//

import Foundation

struct RateRequest: Encodable
{
    var recipe_id: String
    var comment: String
    var rating: String
}

struct RateResponse: Decodable
{
    var message: String?
    let success: String?
    let error: String?
}

struct ReviewInfoModal{
    
    var id, comment, profileImage, firstName, lastName: String
}

struct ReviewRequest: Encodable
{
    let recipe_id: String
    let page: String
    let limit: String
}

struct ReviewResponse: Decodable {
    let reviews: [Review]
    let success: String?
    
    enum CodingKeys: String, CodingKey {
            case reviews, success
        }
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           reviews = try container.decode([Review].self, forKey: .reviews)
           success = try container.decode(String.self, forKey: .success)
       }
}

// MARK: - Review
struct Review: Decodable {
    let comment, createdAt: String?
    let id, rating, recipeID: Int?
    let status: String?
    let updatedAt: String?
    let user: ReviewUser
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case comment
        case createdAt = "created_at"
        case id, rating
        case recipeID = "recipe_id"
        case status
        case updatedAt = "updated_at"
        case user
        case userID = "user_id"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        comment = try container.decodeIfPresent(String.self, forKey: .comment)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        rating = try container.decodeIfPresent(Int.self, forKey: .rating)
        recipeID = try container.decodeIfPresent(Int.self, forKey: .recipeID)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        user = try container.decode(ReviewUser.self, forKey: .user)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
    }
    
}

// MARK: - User
struct ReviewUser: Decodable {
    let createdAt: String?
    let deviceID: String?
    let deviceType, email: String?
    let emailVerifiedAt: String?
    let firstName: String?
    let forgotPasswordCode: String?
    let id: Int?
    let lastName, profileImage, timezone, updatedAt: String?
    let userType: Int?

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
    
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
        
           createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
           deviceID = try container.decodeIfPresent(String.self, forKey: .deviceID)
           deviceType = try container.decodeIfPresent(String.self, forKey: .deviceType)
           email = try container.decodeIfPresent(String.self, forKey: .email)
           emailVerifiedAt = try container.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
           firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
           forgotPasswordCode = try container.decodeIfPresent(String.self, forKey: .forgotPasswordCode)
           id = try container.decodeIfPresent(Int.self, forKey: .id)
           lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
           profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
           timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
           updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
           userType = try container.decodeIfPresent(Int.self, forKey: .userType)
       }
}
