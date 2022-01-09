//
//  String Protocol+.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 09/01/2022.
//

import Foundation


extension StringProtocol { 
    var cutString: [SubSequence] {
        var cutString: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            cutString.append(self[range])
        }
        return cutString
    }
}