//
//  SignUpViewModel.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    // MARK: - Properties
    
    @Published var id = ""
    @Published var idValidationResult: ValidationResult.ID = .empty
    @Published var idResultVisible: Bool = false
    
    @Published var password = ""
    @Published var passwordValidationResult: ValidationResult.Password = .empty
    @Published var passwordResultVisible: Bool = false
    
    @Published var phoneNumber = ""
    @Published var phoneNumberValidationResult: ValidationResult.PhoneNumber = .empty
    @Published var phoneNumberResultVisible: Bool = false
    
    @Published var email = ""
    @Published var emailValidationResult: ValidationResult.Email = .empty
    @Published var emailResultVisible: Bool = false
    
    @Published var isSignedIn = false
    
    // MARK: - Interfaces
    
    func refineID(_ newID: String) {
        let refinedID = refineInputs(newID, count: 20)
        id = refinedID
    }
    
    func refinePassword(_ newPassword: String) {
        let refinedPassword = refineInputs(newPassword, count: 100)
        password = refinedPassword
    }
    
    func refinePhoneNumber(_ newPhoneNumber: String) {
        let refinedPhoneNumber = refineInputs(newPhoneNumber, count: 13)
        let numericPhoneNumber = refinedPhoneNumber.filter { $0.isNumber }
        phoneNumber = makePhoneNumberFormatted(numericPhoneNumber)
    }
    
    func refineEmail(_ newEmail: String) {
        let refinedEmail = refineInputs(newEmail, count: 320)
        email = refinedEmail
    }
    
    func signUp() throws {
        let newUser = User(
            userID: id,
            phoneNumber: phoneNumber,
            email: email
        )
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(newUser)
        UserDefaults.standard.set(encoded, forKey: "user")
    }
    
    func checkSignInStatus() {
        guard let savedData = UserDefaults.standard.object(forKey: "user") as? Data else {
            isSignedIn = false
            return
        }
        let decoder = JSONDecoder()
        if let _ = try? decoder.decode(User.self, from: savedData) {
            isSignedIn = true
        } else {
            isSignedIn = false
        }
    }
    
    func validateAllFields() -> Bool {
        guard validateID() else {
            idResultVisible = true
            passwordResultVisible = false
            phoneNumberResultVisible = false
            emailResultVisible = false
            return false
        }
        
        guard validatePassword() else {
            idResultVisible = false
            passwordResultVisible = true
            phoneNumberResultVisible = false
            emailResultVisible = false
            return false
        }
        
        guard validatePhoneNumber() else {
            idResultVisible = false
            passwordResultVisible = false
            phoneNumberResultVisible = true
            emailResultVisible = false
            return false
        }
        
        guard validateEmail() else {
            idResultVisible = false
            passwordResultVisible = false
            phoneNumberResultVisible = false
            emailResultVisible = true
            return false
        }
        
        idResultVisible = false
        passwordResultVisible = false
        phoneNumberResultVisible = false
        emailResultVisible = false
        
        return true
    }
}

// MARK: - Refine Input Logics

private extension SignUpViewModel {
    /// 공백 제거 및 최대 입력 길이 제한
    func refineInputs(_ input: String, count: Int) -> String {
        var trimmdInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmdInput.count > count {
            trimmdInput.removeLast(trimmdInput.count - count)
        }
        return trimmdInput
    }
    
    /// 01011111111 -> 010-1111-1111
    func makePhoneNumberFormatted(_ phoneNumber: String) -> String {
        var stringWithHypen = phoneNumber
        
        if stringWithHypen.count > 3 {
            stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 3))
        }
        
        if stringWithHypen.count > 8 {
            stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.endIndex, offsetBy: 8 - stringWithHypen.count))
        }
        
        return stringWithHypen
    }
}

// MARK: - Validation Logics

extension SignUpViewModel {
    func validateID() -> Bool {
        let validation = Validator.validateID(id)
        idValidationResult = validation
        return validation == .valid
    }
    
    func validatePassword() -> Bool {
        let validation = Validator.validatePassword(password)
        passwordValidationResult = validation
        return validation == .valid
    }
    
    func validatePhoneNumber() -> Bool {
        let hypenTrimmedPhoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
        let validation = Validator.validatePhoneNumber(hypenTrimmedPhoneNumber)
        phoneNumberValidationResult = validation
        return validation == .valid
    }
    
    func validateEmail() -> Bool {
        let validation = Validator.validateEmail(email)
        emailValidationResult = validation
        return validation == .valid
    }
}
