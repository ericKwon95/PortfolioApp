//
//  DonutChart.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

import SwiftUI

struct DonutChart: View {
    let stocks: [AssetItem]
    let bonds: [AssetItem]
    let etc: [AssetItem]
    
    var body: some View {
        Canvas { context, size in
            // 도넛 그리기 시작
            let donut = Path { p in
                p.addEllipse(in: CGRect(origin: .zero, size: size)) // 외부 원 그리기
                p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5)) // 내부 원 그리기
            }
            context.clip(to: donut, style: .init(eoFill: true)) // 도넛 영역만 그리기
            // 도넛 그리기 끝
            let total = 100.0
            context.translateBy(x: size.width * 0.5, y: size.height * 0.5) // 뷰 중앙으로 도넛 차트 중심 이동
            var pieContext = context // 슬라이스 그리기 위한 컨텍스트
            pieContext.rotate(by: .degrees(-90)) // 시작 지점 12시 방향으로 설정
            let radius = min(size.width, size.height) / 2 // radius 설정
            
            var startAngle = Angle.zero // 시작 각도는 0
            for i in stocks.indices {
                let angle = Angle(degrees: 360 * (stocks[i].ratio / total)) // 슬라이스 비율로 각도 계산
                let endAngle = startAngle + angle // 슬라이스 끝 각도 계산
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(.stock.adjustBrightness(Double(i) * -0.1)))
                startAngle = endAngle // 마지막 앵글에서 시작
            }
            for i in bonds.indices {
                let angle = Angle(degrees: 360 * (bonds[i].ratio / total)) // 슬라이스 비율로 각도 계산
                let endAngle = startAngle + angle // 슬라이스 끝 각도 계산
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(.bond.adjustBrightness(Double(i) * -0.1)))
                startAngle = endAngle // 마지막 앵글에서 시작
            }
            for i in etc.indices {
                let angle = Angle(degrees: 360 * (etc[i].ratio / total)) // 슬라이스 비율로 각도 계산
                let endAngle = startAngle + angle // 슬라이스 끝 각도 계산
                let path = Path { p in
                    p.move(to: .zero)
                    p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                    p.closeSubpath()
                }
                pieContext.fill(path, with: .color(.etc.adjustBrightness(Double(i) * -0.1)))
                startAngle = endAngle // 마지막 앵글에서 시작
            }
        }
        .aspectRatio(1, contentMode: .fit) // 원 만들기
    }
}
