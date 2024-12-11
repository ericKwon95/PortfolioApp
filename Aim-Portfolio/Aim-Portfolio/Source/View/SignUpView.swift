//
//  ContentView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import SwiftUI

struct SignUpView: View {
    enum FocusField {
        case id
        case password
        case phoneNumber
        case email
    }
    
    @StateObject private var viewModel = SignUpViewModel()
    @FocusState private var focusField: FocusField?

    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 8) {
                Spacer()
                
                idInputField
                
                passwordInputFied
                
                phoneNumberInputField
                
                emailInputField
                
                signUpButton()
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.checkSignInStatus()
                focusField = .id
            }
        }
        .onTapGesture {
            hideKeyboard()
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
                    .focused($focusField, equals: .id)
                    .onSubmit {
                        let isAllValidated = validateAndmoveFocusToInvalidField()
                        if isAllValidated {
                            hideKeyboard()
                        } else if viewModel.idValidationResult == .valid {
                            focusField = .password
                        }
                    }
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
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        let isAllValidated = validateAndmoveFocusToInvalidField()
                        if isAllValidated {
                            hideKeyboard()
                        } else if viewModel.passwordValidationResult == .valid {
                            focusField = .phoneNumber
                        }
                    }
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
                    .keyboardType(.numbersAndPunctuation)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focusField, equals: .phoneNumber)
                    .onSubmit {
                        let isAllValidated = validateAndmoveFocusToInvalidField()
                        if isAllValidated {
                            hideKeyboard()
                        } else if viewModel.phoneNumberValidationResult == .valid {
                            focusField = .email
                        }
                    }
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
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        let isAllValidated = validateAndmoveFocusToInvalidField()
                        if isAllValidated {
                            hideKeyboard()
                        }
                    }
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
            let isAllValidated = validateAndmoveFocusToInvalidField()
            if isAllValidated {
                viewModel.signUp()
            }
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

private extension SignUpView {
    func validateAndmoveFocusToInvalidField() -> Bool {
        let isAllValidate = viewModel.validateAllFields()
        if viewModel.idResultVisible {
            focusField = .id
        } else if viewModel.passwordResultVisible {
            focusField = .password
        } else if viewModel.phoneNumberResultVisible {
            focusField = .phoneNumber
        } else if viewModel.emailResultVisible {
            focusField = .email
        }
        return isAllValidate
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

#Preview {
    SignUpView()
}
