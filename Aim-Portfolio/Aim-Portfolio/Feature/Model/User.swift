//
//  User.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/10/24.
//

import Foundation

struct User: Identifiable {
    let id = UUID().uuidString
    let userID: String
    let phoneNumber: String
    let email: String
}
