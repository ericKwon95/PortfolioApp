//
//  AssetDTO.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

import Foundation

struct AssetDTO: Decodable {
    let symbol: String
    let type: String
    let quantity: Int
    let ratio: Double
    let name: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "security_symbol"
        case type = "type"
        case quantity = "quantity"
        case ratio = "ratio"
        case name = "security_name"
        case description = "security_description"
    }
}
