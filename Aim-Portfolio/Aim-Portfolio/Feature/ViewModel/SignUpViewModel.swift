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
        let validation = Validator.validateID(newID)
        idValidationResult = validation.description
    }
    
    func validateNewPassword(_ newPassword: String) {
        let validation = Validator.validatePassword(newPassword)
        passwordValidationResult = validation.description
    }
}
