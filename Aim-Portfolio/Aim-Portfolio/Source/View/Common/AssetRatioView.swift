//
//  AssetRatioView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

import SwiftUI

struct AssetRatioView: View {
    let type: AssetType
    let assets: [AssetItem]
    let baseColor: Color
    
    init(type: AssetType, assets: [AssetItem], baseColor: Color) {
        self.type = type
        self.assets = assets
        self.baseColor = baseColor
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(type.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.assetTypeTitle)
                Spacer()
            }
            ForEach(Array(zip(assets.indices, assets)), id: \.0) { index, asset in
                assetInfo(asset, color: baseColor.adjustBrightness(Double(index) * -0.1))
            }
        }
    }
    
    private func assetInfo(_ asset: AssetItem, color: Color) -> some View {
        HStack(spacing: 0) {
            Text(asset.name)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.white)
                .frame(width: 100, alignment: .leading)
                .padding(.trailing, 16)
            RatioBar(ratio: asset.ratio, color: color)
            Spacer()
            Text("\(String(format: "%.2f", asset.ratio))%")
                .font(.system(size: 14, weight: .regular))
                .frame(width: 70, alignment: .trailing)
                .foregroundStyle(color)
                .monospacedDigit()
        }
    }
}
