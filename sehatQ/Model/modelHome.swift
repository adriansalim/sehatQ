//
//  modelHome.swift
//  sehatQ
//
//  Created by adriansalim on 23/08/21.
//  Copyright © 2020 adriansalim. All rights reserved.
//


import Foundation

// MARK: - WelcomeElement
struct modelHomeElement: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let category: [Category]
    let productPromo: [ProductPromo]
}

// MARK: - Category
struct Category: Codable {
    let imageURL: String
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case id, name
    }
}

// MARK: - ProductPromo
struct ProductPromo: Codable {
    let id: String
    let imageURL: String
    let title, productPromoDescription, price: String
    let loved: Int

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case title
        case productPromoDescription = "description"
        case price, loved
    }
}

typealias modelHome = [modelHomeElement]
