//
//  ApiResponse.swift
//  ListApp
//
//  Created by Mathis Detourbet on 18/3/20.
//  Copyright © 2020 Mathis Detourbet. All rights reserved.
//

import Foundation

struct ApiResponse {
    
    let message: [String]
}

extension ApiResponse: Decodable {}
