//
//  ContentView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            TextField("id", text: $viewModel.id)
                .keyboardType(.asciiCapable)
                .disableAutocorrection(true)
                .onChange(of: viewModel.id) { newID in
                    viewModel.validateNewID(newID)
                }
            Text(viewModel.idValidationResult)
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
