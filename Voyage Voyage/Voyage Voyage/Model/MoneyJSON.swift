//
//  MoneyJSON.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 08/01/2022.
//

import Foundation

struct MoneyJSONStructure {
    let date: String?
    let base: String?
    
}

extension MoneyJSONStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case base = "base"
    }
}
