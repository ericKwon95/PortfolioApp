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
