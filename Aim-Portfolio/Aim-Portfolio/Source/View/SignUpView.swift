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
        VStack(spacing: 8) {
            idInputField
            
            passwordInputFied
            
            phoneNumberInputField
            
            emailInputField
            
            signUpButton()
        }
        .padding()
        .onAppear {
            viewModel.checkSignInStatus()
        }
    }
    
    private var idInputField: some View {
        VStack(spacing: 8) {
            HStack{
                Text("아이디")
                    .foregroundStyle(.appPrimary)
                    .font(.system(size: 14))
                Spacer()
            }
            HStack {
                TextField("아이디를 입력해주세요", text: $viewModel.id)
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onChange(of: viewModel.id) { newID in
                        viewModel.refineID(newID)
                    }
                checkMarkImage
                    .opacity(viewModel.idValidationResult == .valid ? 1 : 0)
                    .animation(.bouncy, value: viewModel.idValidationResult)
            }
            divider
            validationResult(viewModel.idValidationResult.description)
                .opacity(viewModel.idResultVisible ? 1 : 0)
        }
    }
    
    private var passwordInputFied: some View {
        VStack(spacing: 8) {
            HStack{
                Text("비밀번호")
                    .foregroundStyle(.appPrimary)
                    .font(.system(size: 14))
                Spacer()
            }
            HStack {
                SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                    .keyboardType(.asciiCapable)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onChange(of: viewModel.password) { newPassword in
                        viewModel.refinePassword(newPassword)
                    }
                checkMarkImage
                    .opacity(viewModel.passwordValidationResult == .valid ? 1 : 0)
            }
            divider
            validationResult(viewModel.passwordValidationResult.description)
                .opacity(viewModel.passwordResultVisible ? 1 : 0)
        }
    }
    
    private var phoneNumberInputField: some View {
        VStack(spacing: 8) {
            HStack{
                Text("전화번호")
                    .foregroundStyle(.appPrimary)
                    .font(.system(size: 14))
                Spacer()
            }
            HStack {
                TextField("전화번호를 입력해주세요", text: $viewModel.phoneNumber)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onChange(of: viewModel.phoneNumber) { newPhoneNumber  in
                        viewModel.refinePhoneNumber(newPhoneNumber)
                    }
                checkMarkImage
                    .opacity(viewModel.phoneNumberValidationResult == .valid ? 1 : 0)
            }
            divider
            validationResult(viewModel.phoneNumberValidationResult.description)
                .opacity(viewModel.phoneNumberResultVisible ? 1 : 0)
        }
    }
    
    private var emailInputField: some View {
        VStack(spacing: 8) {
            HStack{
                Text("이메일")
                    .foregroundStyle(.appPrimary)
                    .font(.system(size: 14))
                Spacer()
            }
            HStack {
                TextField("이메일을 입력해주세요", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .onChange(of: viewModel.email) { newEmail in
                        viewModel.refineEmail(newEmail)
                    }
                checkMarkImage
                    .opacity(viewModel.emailValidationResult == .valid ? 1 : 0)
            }
            divider
            validationResult(viewModel.emailValidationResult.description)
                .opacity(viewModel.emailResultVisible ? 1 : 0)
        }
    }
    
    private var checkMarkImage: some View {
        Image(systemName: "checkmark")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.appPrimary)
            .frame(width: 20, height: 20)
    }
    
    private func validationResult(_ resultText: String) -> some View {
        HStack {
            Text(resultText)
                .font(.system(size: 12))
                .foregroundStyle(.red)
            Spacer()
        }
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.appPrimary)
    }
    
    private func signUpButton() -> some View {
        Button {
            viewModel.signUp()
        } label: {
            HStack {
                Spacer()
                Text("회원가입")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(8)
                Spacer()
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.appPrimary)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SignUpView()
}
