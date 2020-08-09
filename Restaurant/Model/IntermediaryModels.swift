//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Dimon on 28.06.2020.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}

