//
//  SplashView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/13/24.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var coordinator = Coordinator<Destination>()
    @State private var isSplashComplete = false
    @State private var isSignedUp = false
    
    var body: some View {
        if isSplashComplete {
            NavigationStack(path: $coordinator.paths) {
                if isSignedUp {
                    mainView
                } else {
                    signupView
                }
            }
        } else {
            splashView
                .onAppear {
                    checkSignUpStatus()
                    isSplashComplete = true
                }
        }
    }
    
    private var mainView: some View {
        MainView()
            .environmentObject(coordinator)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .signup:
                    SignUpView()
                        .environmentObject(coordinator)
                case .main:
                    MainView()
                        .environmentObject(coordinator)
                case let .allStocks(viewModel):
                    AllStocksView(viewModel: viewModel)
                        .environmentObject(coordinator)
                }
            }
    }
    
    private var signupView: some View {
        SignUpView()
            .environmentObject(coordinator)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .signup:
                    SignUpView()
                        .environmentObject(coordinator)
                case .main:
                    MainView()
                        .environmentObject(coordinator)
                case let .allStocks(viewModel):
                    AllStocksView(viewModel: viewModel)
                        .environmentObject(coordinator)
                }
            }
    }
    
    private var splashView: some View {
        ZStack {
            Color.appPrimary
                .ignoresSafeArea()
            Text("Aim")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
        }
    }
    
    private func checkSignUpStatus() {
        isSignedUp =  UserDefaults.standard.object(forKey: "user") != nil
    }
}

#Preview {
    SplashView()
}
