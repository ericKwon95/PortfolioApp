//
//  PortfolioViewModel.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import Foundation

final class PortfolioViewModel: ObservableObject {
    @Published var allAssetItems: [AssetItem] = []
    @Published var stocks: [AssetItem] = []
    @Published var bonds: [AssetItem] = []
    @Published var etc: [AssetItem] = []
    
    init() {
        loadAssetItems()
    }
    
    private func loadAssetItems() {
        guard let data = try? JSONLoader.loadJSON(from: "testFile") as [AssetDTO] else {
            print("Error loading JSON")
            return
        }
        let assetData = data.map {
            AssetItem(from: $0)
        }
        allAssetItems = assetData
        assetData.forEach { item in
            switch item.type {
            case .stock:
                stocks.append(item)
            case .bond:
                bonds.append(item)
            case .etc:
                etc.append(item)
            }
        }
    }
}
