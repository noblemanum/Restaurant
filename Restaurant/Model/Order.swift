//
//  Order.swift
//  Restaurant
//
//  Created by Dimon on 28.06.2020.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
