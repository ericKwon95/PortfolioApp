//
//  AssetItem.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import Foundation

enum AssetType: String {
    case stock
    case bond
    case etc
    
    var description: String {
        switch self {
        case .stock:
            return "주식형 자산"
        case .bond:
            return "채권형 자산"
        case .etc:
            return "기타 자산"
        }
    }
}

struct AssetItem: Identifiable {
    let id = UUID().uuidString
    let symbol: String
    let type: AssetType
    let quantity: Int
    let ratio: Double
    let name: String
    let description: String

    init(from dto: AssetDTO) {
        self.symbol = dto.symbol
        self.type = AssetType(rawValue: dto.type) ?? .etc
        self.quantity = dto.quantity
        self.ratio = dto.ratio
        self.name = dto.name
        self.description = dto.description
    }
}
