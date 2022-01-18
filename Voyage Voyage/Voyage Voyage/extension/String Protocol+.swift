//
//  String Protocol+.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 09/01/2022.
//

import Foundation

//MARK: cut string and put in a table
extension StringProtocol {
    var cutString: [SubSequence] {
        var cutString: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            cutString.append(self[range])
        }
        return cutString
    }
}

//MARK: replace one character with another in a string
extension String {
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}

