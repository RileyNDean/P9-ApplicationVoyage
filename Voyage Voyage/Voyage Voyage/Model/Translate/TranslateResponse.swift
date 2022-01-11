//
//  BaseLang.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

struct TranslatedText: Decodable {
    let text: [String]
    let lang: String
}
