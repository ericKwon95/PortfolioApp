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
}
