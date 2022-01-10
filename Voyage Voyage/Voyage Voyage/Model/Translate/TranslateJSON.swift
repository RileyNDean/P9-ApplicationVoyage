//
//  BaseLang.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

struct BaseLang: Codable {
    var lang: String
}

struct TextTranslate: Decodable {
    let text: [String]
    let lang: String
}

