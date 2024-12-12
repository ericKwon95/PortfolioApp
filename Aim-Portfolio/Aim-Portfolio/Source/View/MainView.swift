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
                DonutChart(
                    stocks: viewModel.stocks,
                    bonds: viewModel.bonds,
                    etc: viewModel.etc
                )
                
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
}

#Preview {
    MainView()
}
