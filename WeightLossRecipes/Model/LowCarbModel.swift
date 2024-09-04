//
//  LowCarbModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 03/10/2023.
//

import Foundation

struct LowCarbsInfoModel{
    
    let title, descriptions: String
    var isDetail: Bool
    var isSelected: Bool
    var isCellSelected: Bool
}

struct LowCarbsResponse: Decodable {
    let faqs: [FAQ]
    let success: String
}

// MARK: - FAQ
struct FAQ: Decodable {
    let createdAt, descriptions: String?
    let id, status: Int?
    let title, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case descriptions, id, status, title
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        createdAt = try? container.decode(String.self, forKey: .createdAt)
        descriptions = try? container.decode(String.self, forKey: .descriptions)
        id = try? container.decode(Int.self, forKey: .id)
        status = try? container.decode(Int.self, forKey: .status)
        title = try? container.decode(String.self, forKey: .title)
        updatedAt = try? container.decode(String.self, forKey: .updatedAt)
    }
    
//    init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//
//            id = try container.decode(Int.self, forKey: .id)
//            title = try container.decode(String.self, forKey: .title)
//            premium = try container.decode(Int.self, forKey: .premium)
//            image = try container.decode(String.self, forKey: .image)
//            banner = try container.decode(String.self, forKey: .banner)
//            description = try container.decode(String.self, forKey: .description)
//            ingredients = try container.decode(String.self, forKey: .ingredients)
//            instructions = try container.decode(String.self, forKey: .instructions)
//            clicksCount = try container.decode(Int.self, forKey: .clicksCount)
//            createdAt = try container.decode(String.self, forKey: .createdAt)
//            updatedAt = try container.decode(String.self, forKey: .updatedAt)
//            reviewsCount = try container.decode(Int.self, forKey: .reviewsCount)
//
//            // Decode avgRating as a Double if it's a valid number or set it to nil otherwise.
//            avgRating = try? container.decode(Double.self, forKey: .avgRating)
//        }
}
