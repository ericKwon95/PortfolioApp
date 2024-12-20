//
//  AllStocksView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

import SwiftUI

struct AllStocksView: View {
    @EnvironmentObject private var coordinator: Coordinator<Destination>
    @ObservedObject var viewModel: PortfolioViewModel
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                Color.appPrimary
                    .frame(height: max(0, UIScreen.main.bounds.height / 5 - scrollOffset / 2))
                    .ignoresSafeArea()
                Color.allStockBackground
                    .ignoresSafeArea()
            }
            stockList
            navigationBar
        }
        .toolbar(.hidden)
    }
    
    private var navigationBar: some View {
        VStack(spacing: 0) {
            HStack{
                backButton
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                Spacer()
            }
            .background {
                Color.appPrimary.ignoresSafeArea()
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var title: some View {
        HStack {
            Text("현재 보유중인 주식")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.leading, 16)
        HStack {
            Text("각 ETF 종목별 기본 정보, 보유 수량 정보입니다.")
                .font(.system(size: 14))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.leading, 16)
    }
    
    private var backButton: some View {
        Image(systemName: "arrow.left")
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .foregroundStyle(.white)
            .contentShape(Rectangle().size(width: 44, height: 44))
            .onTapGesture {
                coordinator.pop()
            }
    }
    
    private var stockList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                title
                ForEach(viewModel.stocks) { stock in
                    StockRow(
                        ticker: stock.symbol,
                        name: stock.name,
                        description: stock.description,
                        quantity: stock.quantity
                    )
                }
                ForEach(viewModel.bonds) { bond in
                    StockRow(
                        ticker: bond.symbol,
                        name: bond.name,
                        description: bond.description,
                        quantity: bond.quantity
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
            .padding(.bottom, 32)
            .background {
                GeometryReader {
                    Color.clear.preference(
                        key: ViewOffsetKey.self,
                        value: -$0.frame(in: .named("scroll")).origin.y
                    )
                }
            }
            .onPreferenceChange(ViewOffsetKey.self) {
                scrollOffset = $0
            }
        }
        .coordinateSpace(name: "scroll")
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    AllStocksView(viewModel: PortfolioViewModel())
        .environmentObject(Coordinator<Destination>())
}
