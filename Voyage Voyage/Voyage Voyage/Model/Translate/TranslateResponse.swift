//
//  BaseLang.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

struct TranslatedTextResponse: Decodable {
    let text: [String]
    let lang: String
}

struct TranslatedText: Decodable {
    let text: String
    let lang: String
}
