//
//  Validator.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import Foundation

enum ValidationResult {
    enum ID {
        case valid
        case tooShort
        case tooLong
        case invalidCharacter
        
        var description: String {
            switch self {
            case .valid:
                return "사용할 수 있는 아이디 입니다."
            case .tooShort:
                return "아이디는 7자 이상이어야 합니다."
            case .tooLong:
                return "아이디는 20자를 넘을 수 없습니다."
            case .invalidCharacter:
                return "아이디는 영문자만 포함할 수 있습니다."
            }
        }
    }
            }
        }
    }
}

struct Validator {
    static func validateID(_ id: String) -> ValidationResult.ID {
        guard id.count >= 7 else {
            return .tooShort
        }
        
        guard id.count <= 20 else {
            return .tooLong
        }
        
        let alphabets = /[A-Za-z]+/
        guard id.wholeMatch(of: alphabets) != nil else {
            return .invalidCharacter
        }
        
        return .valid
    }
}
