//
//  RatioBar.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

import SwiftUI

struct RatioBar: View {
    let ratio: Double
    let color: Color
    let brightness: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.ratioBarBackground)
            .frame(height: 6)
            .frame(maxWidth: .infinity)
            .overlay {
                GeometryReader { proxy in
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(color)
                            .frame(width: proxy.size.width * (ratio / 100), height: 6)
                            .brightness(brightness)
                        Spacer()
                    }
                }
            }
    }
}

#Preview {
    RatioBar(ratio: 50, color: .red, brightness: 0)
}
