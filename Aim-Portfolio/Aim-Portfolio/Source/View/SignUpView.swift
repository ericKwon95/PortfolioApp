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
                    viewModel.refineID(newID)
                }
            Text(viewModel.idValidationResult)
            SecureField("password", text: $viewModel.password)
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: viewModel.password) { newPassword in
                    viewModel.refinePassword(newPassword)
                }
            Text(viewModel.passwordValidationResult)
            TextField("phoneNumber", text: $viewModel.phoneNumber)
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: viewModel.phoneNumber) { newPhoneNumber  in
                    viewModel.refinePhoneNumber(newPhoneNumber)
                }
            Text(viewModel.phoneNumberValidationResult)
            TextField("email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .onChange(of: viewModel.email) { newEmail in
                    viewModel.refineEmail(newEmail)
                }
            Text(viewModel.emailValidationResult)
            Button {
                viewModel.signUp()
            } label: {
                Text("회원가입")
            }
        }
        .padding()
        .onAppear {
            viewModel.checkSignInStatus()
        }
    }
}

#Preview {
    SignUpView()
}
