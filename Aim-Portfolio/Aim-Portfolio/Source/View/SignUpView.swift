//
//  ContentView.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import SwiftUI

enum FocusField {
    case id
    case password
    case phoneNumber
    case email
}

struct SignUpView: View {
    @EnvironmentObject private var coordinator: Coordinator<Destination>
    @StateObject private var viewModel = SignUpViewModel()
    @FocusState private var focusField: FocusField?
    @State private var idInterval: CGFloat = 0
    @State private var passwordInterval: CGFloat = 0
    @State private var phoneNumberInterval: CGFloat = 0
    @State private var emailInterval: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 8) {
                Spacer()
                
                idInputField
                passwordInputFied
                phoneNumberInputField
                emailInputField
                
                signUpButton
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.checkSignInStatus()
                focusField = .id
            }
        }
        .toolbar(.hidden)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var idInputField: some View {
        InputTextView(
            text: $viewModel.id,
            description: viewModel.idValidationResult.description,
            isValid: viewModel.idValidationResult.isValid,
            isVisible: viewModel.idResultVisible,
            title: "아이디",
            placeholder: "아이디를 입력해주세요",
            isSecure: false,
            keyboardType: .asciiCapable,
            interval: idInterval,
            onSubmit: {
                moveToNextFieldIfValid()
            },
            onChange: { newID in
                viewModel.refineID(newID)
                _ = viewModel.validateID()
            }
        )
        .focused($focusField, equals: .id)
    }
    
    private var passwordInputFied: some View {
        InputTextView(
            text: $viewModel.password,
            description: viewModel.passwordValidationResult.description,
            isValid: viewModel.passwordValidationResult.isValid,
            isVisible: viewModel.passwordResultVisible,
            title: "비밀번호",
            placeholder: "비밀번호를 입력해주세요",
            isSecure: true,
            keyboardType: .asciiCapable,
            interval: passwordInterval,
            onSubmit: {
                moveToNextFieldIfValid()
            },
            onChange: { newPassword in
                viewModel.refinePassword(newPassword)
                _ = viewModel.validatePassword()
            }
        )
        .focused($focusField, equals: .password)
    }
    
    private var phoneNumberInputField: some View {
        InputTextView(
            text: $viewModel.phoneNumber,
            description: viewModel.phoneNumberValidationResult.description,
            isValid: viewModel.phoneNumberValidationResult.isValid,
            isVisible: viewModel.phoneNumberResultVisible,
            title: "전화번호",
            placeholder: "전화번호를 입력해주세요",
            isSecure: false,
            keyboardType: .numbersAndPunctuation,
            interval: phoneNumberInterval,
            onSubmit: {
                moveToNextFieldIfValid()
            },
            onChange: { newPhoneNumber in
                viewModel.refinePhoneNumber(newPhoneNumber)
                _ = viewModel.validatePhoneNumber()
            }
        )
        .focused($focusField, equals: .phoneNumber)
    }
    
    private var emailInputField: some View {
        InputTextView(
            text: $viewModel.email,
            description: viewModel.emailValidationResult.description,
            isValid: viewModel.emailValidationResult.isValid,
            isVisible: viewModel.emailResultVisible,
            title: "이메일",
            placeholder: "이메일을 입력해주세요",
            isSecure: false,
            keyboardType: .emailAddress,
            interval: emailInterval,
            onSubmit: {
                moveToNextFieldIfValid()
            },
            onChange: { newEmail in
                viewModel.refineEmail(newEmail)
                _ = viewModel.validateEmail()
            }
        )
        .focused($focusField, equals: .email)
    }
    
    private var signUpButton: some View {
        Button {
            validateAndSignUp()
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
    
    private func validateAndSignUp() {
        guard validateAndMoveFocusToInvalidField() else { return }
        do {
            try viewModel.signUp()
            coordinator.push(.main)
        } catch {
            print(error)
        }
    }
}

private extension SignUpView {
    private func moveToNextFieldIfValid() {
        switch focusField {
        case .id:
            if viewModel.idValidationResult == .valid,
               viewModel.passwordValidationResult == .empty {
                focusField = .password
            } else {
                let isAllValid = validateAndMoveFocusToInvalidField()
                if isAllValid {
                    hideKeyboard()
                }
            }
        case .password:
            if viewModel.passwordValidationResult == .valid,
               viewModel.phoneNumberValidationResult == .empty{
                focusField = .phoneNumber
            } else {
                let isAllValid = validateAndMoveFocusToInvalidField()
                if isAllValid {
                    hideKeyboard()
                }
            }
        case .phoneNumber:
            if viewModel.phoneNumberValidationResult == .valid,
               viewModel.emailValidationResult == .empty {
                focusField = .email
            } else {
                let isAllValid = validateAndMoveFocusToInvalidField()
                if isAllValid {
                    hideKeyboard()
                }
            }
        case .email:
            let isAllValid = validateAndMoveFocusToInvalidField()
            if isAllValid {
                hideKeyboard()
            }
        case .none:
            break
        }
    }
    
    func validateAndMoveFocusToInvalidField() -> Bool {
        let isAllValidate = viewModel.validateAllFields()
        if viewModel.idResultVisible {
            focusField = .id
            withAnimation(.easeInOut) {
                idInterval += 1
            }
        } else if viewModel.passwordResultVisible {
            focusField = .password
            withAnimation(.easeInOut) {
                passwordInterval += 1
            }
        } else if viewModel.phoneNumberResultVisible {
            focusField = .phoneNumber
            withAnimation(.easeInOut) {
                phoneNumberInterval += 1
            }
        } else if viewModel.emailResultVisible {
            focusField = .email
            withAnimation(.easeInOut) {
                emailInterval += 1
            }
        }
        return isAllValidate
    }
}

#Preview {
    SignUpView()
        .environmentObject(Coordinator<Destination>())
}
