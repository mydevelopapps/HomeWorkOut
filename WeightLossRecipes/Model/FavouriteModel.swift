//
//  FavouriteModel.swift
//  WeightLossRecipes
//
//  Created by Curiologix on 23/09/2023.
//

import Foundation


struct FavInfoModel{
    
    var id, premium: Int?
    var title, banner_thumbnail, image_thumbnail, ingrediants, instructions: String?
}

struct GetFavResponse: Codable {
    let recipes: [RecipeFav]
    let success: String
}

// MARK: - Recipe
struct RecipeFav: Codable {
    let banner: String
    let clicksCount: Int
    let createdAt, description: String
    let id: Int
    let image, ingredients, instructions: String
    let premium: Int
    let title, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case banner
        case clicksCount = "clicks_count"
        case createdAt = "created_at"
        case description, id, image, ingredients, instructions, premium, title
        case updatedAt = "updated_at"
    }
}

