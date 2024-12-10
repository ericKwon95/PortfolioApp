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
    
    func validateNewID(_ newID: String) {
        let trimmedID = newID.trimmingCharacters(in: .whitespacesAndNewlines)
        let validation = Validator.validateID(trimmedID)
        idValidationResult = validation.description
        id = trimmedID
    }
    
    func validateNewPassword(_ newPassword: String) {
        let trimmedPassword = newPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let validation = Validator.validatePassword(trimmedPassword)
        passwordValidationResult = validation.description
        password = trimmedPassword
    }
    
    func validateNewPhoneNumber(_ newPhoneNumber: String) {
        let spaceTrimmed = newPhoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let hypenTrimmed = spaceTrimmed.replacingOccurrences(of: "-", with: "")
        let validation = Validator.validatePhoneNumber(hypenTrimmed)
        phoneNumberValidationResult = validation.description
        let formattedPhoneNumber = makePhoneNumberFormatted(hypenTrimmed)
        phoneNumber = formattedPhoneNumber
    }
    
    func validateNewEmail(_ newEmail: String) {
        let trimmedEmail = newEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        let validation = Validator.validateEmail(trimmedEmail)
        emailValidationResult = validation.description
        email = trimmedEmail
    }
    
    func signUp() {
        let newUser = User(
            userID: id,
            phoneNumber: phoneNumber,
            email: email
        )
        UserDefaults.standard.set(newUser, forKey: "user")
    }
    
    func checkSignInStatus() {
        if let user = UserDefaults.standard.object(forKey: "user") as? User {
            isSignedIn = true
            id = user.userID
            phoneNumber = user.phoneNumber
            email = user.email
        } else {
            isSignedIn = false
        }
    }
}

private extension SignUpViewModel {
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
