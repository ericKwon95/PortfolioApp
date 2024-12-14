//
//  Destination.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/13/24.
//

enum Destination: Hashable {
    case signup
    case main
    case allStocks(PortfolioViewModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .signup:
            hasher.combine(0)
        case .main:
            hasher.combine(1)
        case .allStocks(let viewModel):
            hasher.combine(2)
            hasher.combine(ObjectIdentifier(viewModel))
        }
    }
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
        case (.signup, .signup):
            return true
        case (.main, .main):
            return true
        case (.allStocks(let lhsViewModel), .allStocks(let rhsViewModel)):
            return lhsViewModel === rhsViewModel
        default:
            return false
        }
    }
}
