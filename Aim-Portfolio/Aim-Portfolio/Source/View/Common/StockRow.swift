//
//  StockRow.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

import SwiftUI

struct StockRow: View {
    let ticker: String
    let name: String
    let description: String
    let quantity: Int
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 8) {
                stockTitle
                stockDescription
                Spacer()
            }
            .padding(.trailing, 16)
            stockQuantity
        }
        .padding(32)
        .frame(height: 150)
        .background {
            Rectangle()
                .fill(Color.white)
                .shadow(radius: 0.5)
        }
    }
    
    private var stockTitle: some View {
        HStack {
            Text(ticker)
                .font(.system(size: 16, weight: .bold))
            Text(name)
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
    }
    
    private var stockDescription: some View {
        HStack {
            Text(description.splitWord())
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(.assetTypeTitle)
                .truncationMode(.head)
            Spacer()
        }
    }
    
    private var stockQuantity: some View {
        Text("\(quantity)주")
            .font(.system(size: 32, weight: .semibold))
            .foregroundStyle(.appPrimary)
            .monospacedDigit()
    }
}

#Preview {
    StockRow(
        ticker: "APPL",
        name: "애플",
        description: "애플 세계최강의 애플주식",
        quantity: 1
    )
}
