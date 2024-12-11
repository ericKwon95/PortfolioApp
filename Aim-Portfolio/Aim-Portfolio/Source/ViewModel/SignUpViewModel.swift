//
//  SignUpViewModel.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var id = ""
    @Published var idValidationResult = " "
    
    @Published var password = ""
    @Published var passwordValidationResult = " "
    
    @Published var phoneNumber = "010-"
    @Published var phoneNumberValidationResult = " "
    
    @Published var email = ""
    @Published var emailValidationResult = " "
    
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
        let hypenTrimmedPhoneNumber = refinedPhoneNumber.replacingOccurrences(of: "-", with: "")
        phoneNumber = makePhoneNumberFormatted(hypenTrimmedPhoneNumber)
    }
    
    func refineEmail(_ newEmail: String) {
        let refinedEmail = refineInputs(newEmail, count: 320)
        email = refinedEmail
    }
    
    func signUp() {
        guard validateAllFields() else {
            return
        }
        
        let newUser = User(
            userID: id,
            phoneNumber: phoneNumber,
            email: email
        )
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newUser) {
            UserDefaults.standard.set(encoded, forKey: "user")
        }
    }
    
    func checkSignInStatus() {
        guard let savedData = UserDefaults.standard.object(forKey: "user") as? Data else {
            isSignedIn = false
            return
        }
        
        let decoder = JSONDecoder()
        if let savedUser = try? decoder.decode(User.self, from: savedData) {
            isSignedIn = true
        } else {
            isSignedIn = false
        }
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

private extension SignUpViewModel {
    func validateAllFields() -> Bool {
        guard validateID() else {
            return false
        }
        
        guard validatePassword() else {
            return false
        }
        
        guard validatePhoneNumber() else {
            return false
        }
        
        guard validateEmail() else {
            return false
        }
        
        return true
    }
    
    func validateID() -> Bool {
        let validation = Validator.validateID(id)
        idValidationResult = validation.description
        return validation == .valid
    }
    
    func validatePassword() -> Bool {
        let validation = Validator.validatePassword(password)
        passwordValidationResult = validation.description
        return validation == .valid
    }

    func validatePhoneNumber() -> Bool {
        let hypenTrimmedPhoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
        let validation = Validator.validatePhoneNumber(hypenTrimmedPhoneNumber)
        phoneNumberValidationResult = validation.description
        return validation == .valid
    }
    
    func validateEmail() -> Bool {
        let validation = Validator.validateEmail(email)
        emailValidationResult = validation.description
        return validation == .valid
    }
}
