//
//  View+.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
