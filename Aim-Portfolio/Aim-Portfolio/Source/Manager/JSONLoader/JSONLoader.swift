//
//  JSONLoader.swift
//  Aim-Portfolio
//
//  Created by 권승용 on 12/11/24.
//

import Foundation

struct JSONLoader {
    static func loadJSON<T: Decodable>(from fileName: String) throws -> T {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
