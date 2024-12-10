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
    
    func validateNewID(_ newID: String) {
        let validation = Validator.validateID(newID)
        switch validation {
        case .valid:
            idValidationResult = "사용할 수 있는 아이디 입니다"
        case .tooShort:
            idValidationResult = "너무 짧아요! 7자 이상 입력해 주세요"
        case .tooLong:
            idValidationResult = "너무 길어요! 20자 이하로 입력해 주세요"
        case .invalidCharacter:
            idValidationResult = "아이디에는 영문대소문자만 사용할 수 있습니다"
        }
    }
}
