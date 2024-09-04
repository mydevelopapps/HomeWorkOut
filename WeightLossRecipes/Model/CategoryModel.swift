//
//  CategoryModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 20/09/2023.
//

import Foundation

struct CategoryInfoModel{
    
    var id: Int
    var title, banner_thumbnail, image_thumbnail, ingrediants, instructions: String
}

struct DetailInfoModel{
    
    var id: Int?
    var premium: Int?
    var reviewsCount: Int?
    var title: String?
    var banner_thumbnail: String?
    var image_thumbnail: String?
    var ingrediants: String?
    var instructions: String?
    var avg_rating: String?
}


struct categoryRequest: Encodable{
    var limit: String?
    var category_id: String?
    var page: String?
}

struct CategoryResponse: Decodable {
    let success: String
    let recipes: [CategoryRecipe]
}

// MARK: - Recipe
struct CategoryRecipe: Decodable {
    let id: Int
    let title: String
    let premium: Int
    let image, banner, description, ingredients: String
    let instructions: String
    let clicksCount: Int
    let createdAt, updatedAt: String
    let reviewsCount: Int
    let avgRating: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, premium, image, banner, description, ingredients, instructions
        case clicksCount = "clicks_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case reviewsCount = "reviews_count"
        case avgRating = "avg_rating"
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            premium = try container.decode(Int.self, forKey: .premium)
            image = try container.decode(String.self, forKey: .image)
            banner = try container.decode(String.self, forKey: .banner)
            description = try container.decode(String.self, forKey: .description)
            ingredients = try container.decode(String.self, forKey: .ingredients)
            instructions = try container.decode(String.self, forKey: .instructions)
            clicksCount = try container.decode(Int.self, forKey: .clicksCount)
            createdAt = try container.decode(String.self, forKey: .createdAt)
            updatedAt = try container.decode(String.self, forKey: .updatedAt)
            reviewsCount = try container.decode(Int.self, forKey: .reviewsCount)

            // Decode avgRating as a Double if it's a valid number or set it to nil otherwise.
            avgRating = try? container.decode(Double.self, forKey: .avgRating)
        }
}

struct DetailRequest: Encodable{
    
    var recipe_id: String?
}


struct DetailRecipeResponse: Codable {
    let success: String
    let recipe: DetailRecipe
}

// MARK: - Recipe
struct DetailRecipe: Codable {
    let id: Int?
    let title: String?
    let premium: Int?
    let image, banner, description, ingredients: String?
    let instructions: String?
    let clicksCount: Int?
    let createdAt, updatedAt: String?
    let reviewsCount: Int?
    let avgRating: String?

    enum CodingKeys: String, CodingKey {
        case id, title, premium, image, banner, description, ingredients, instructions
        case clicksCount = "clicks_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case reviewsCount = "reviews_count"
        case avgRating = "avg_rating"
    }
    
    init(from decoder: Decoder) throws {
        
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try? container.decode(Int.self, forKey: .id)
            title = try? container.decode(String.self, forKey: .title)
            premium = try? container.decode(Int.self, forKey: .premium)
            image = try? container.decode(String.self, forKey: .image)
            banner = try? container.decode(String.self, forKey: .banner)
            description = try? container.decode(String.self, forKey: .description)
            ingredients = try? container.decode(String.self, forKey: .ingredients)
            instructions = try? container.decode(String.self, forKey: .instructions)
            clicksCount = try? container.decode(Int.self, forKey: .clicksCount)
            createdAt = try? container.decodeIfPresent(String.self, forKey: .createdAt)
            updatedAt = try? container.decodeIfPresent(String.self, forKey: .updatedAt)
            reviewsCount = try? container.decode(Int.self, forKey: .reviewsCount)
            avgRating = try? container.decodeIfPresent(String.self, forKey: .avgRating)
        }
}

struct AddRemoveFavResponse: Decodable{
    
    let message: String
    let success: String
}
