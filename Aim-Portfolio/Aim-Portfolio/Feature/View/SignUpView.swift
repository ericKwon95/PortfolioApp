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
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: viewModel.id) { newID in
                    viewModel.validateNewID(newID)
                }
            Text(viewModel.idValidationResult)
            SecureField("password", text: $viewModel.password)
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: viewModel.password) { newPassword in
                    viewModel.validateNewPassword(newPassword)
                }
            Text(viewModel.passwordValidationResult)
            TextField("phoneNumber", text: $viewModel.phoneNumber)
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: viewModel.phoneNumber) { newPhoneNumber  in
                    viewModel.validateNewPhoneNumber(newPhoneNumber)
                }
            Text(viewModel.phoneNumberValidationResult)
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
