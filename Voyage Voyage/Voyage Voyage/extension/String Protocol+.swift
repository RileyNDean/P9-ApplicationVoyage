//
//  String Protocol+.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 09/01/2022.
//

import Foundation


extension StringProtocol {  // cut string into a array
    var cutString: [SubSequence] {
        var cutString: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            cutString.append(self[range])
        }
        return cutString
    }
}

extension String { //replace a all of one caracter in a string
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}
