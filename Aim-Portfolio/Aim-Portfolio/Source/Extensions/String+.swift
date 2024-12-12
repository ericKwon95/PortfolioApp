//
//  String+.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/12/24.
//

extension String {
    func splitWord() -> String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
}
