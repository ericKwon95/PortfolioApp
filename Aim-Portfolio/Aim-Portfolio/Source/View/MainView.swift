//
//  MainView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                HStack(spacing: 16) {
                    DonutChart(
                        stocks: viewModel.stocks,
                        bonds: viewModel.bonds,
                        etc: viewModel.etc
                    )
                    portfolioDescription
                }
                .frame(height: 140)
                
                AssetRatioView(
                    type: .stock,
                    assets: viewModel.stocks,
                    baseColor: .stock
                )
                
                AssetRatioView(
                    type: .bond,
                    assets: viewModel.bonds,
                    baseColor: .bond
                )
                
                AssetRatioView(
                    type: .etc,
                    assets: viewModel.etc,
                    baseColor: .etc
                )
            }
            .padding()
        }
        .onAppear {
            viewModel.loadAssetItems()
        }
    }
    
    private var portfolioDescription: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("장기투자에 적합한 적극적인 자산배분")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack(spacing: 0) {
                Text("\'평생안정 은퇴자금\'")
                    .foregroundStyle(.white)
                    .bold()
                Text("에")
                    .font(.system(size: 15))
                    .foregroundStyle(.assetTypeTitle)
            }
            Text("최적화된 자산배분입니다.")
                .font(.system(size: 15))
                .foregroundStyle(.assetTypeTitle)
        }
        .padding()
    }
}

#Preview {
    MainView()
}
