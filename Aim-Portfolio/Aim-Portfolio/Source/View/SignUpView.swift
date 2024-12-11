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
                
                signUpButton
                
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
        InputTextView(
            text: $viewModel.id,
            description: viewModel.idValidationResult.description,
            isValid: viewModel.idValidationResult.isValid,
            isVisible: viewModel.idResultVisible,
            title: "아이디",
            placeholder: "아이디를 입력해주세요",
            isSecure: false,
            keyboardType: .asciiCapable,
            onSubmit: {
                if viewModel.passwordValidationResult == .valid {
                    focusField = .password
                }
                let isAllValidated = validateAndmoveFocusToInvalidField()
                if isAllValidated {
                    hideKeyboard()
                }
            },
            onChange: { newID in
                viewModel.refineID(newID)
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
            onSubmit: {
                if viewModel.passwordValidationResult == .valid {
                    focusField = .phoneNumber
                }
                let isAllValidated = validateAndmoveFocusToInvalidField()
                if isAllValidated {
                    hideKeyboard()
                }
            },
            onChange: { newPassword in
                viewModel.refinePassword(newPassword)
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
            onSubmit: {
                if viewModel.phoneNumberValidationResult == .valid {
                    focusField = .email
                }
                let isAllValidated = validateAndmoveFocusToInvalidField()
                if isAllValidated {
                    hideKeyboard()
                }
            },
            onChange: { newPhoneNumber in
                viewModel.refinePhoneNumber(newPhoneNumber)
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
            onSubmit: {
                let isAllValidated = validateAndmoveFocusToInvalidField()
                if isAllValidated {
                    hideKeyboard()
                }
            },
            onChange: { newEmail in
                viewModel.refineEmail(newEmail)
            }
        )
        .focused($focusField, equals: .email)
    }
    
    private var signUpButton: some View {
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

#Preview {
    SignUpView()
}
