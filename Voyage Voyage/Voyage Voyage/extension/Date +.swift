//
//  Date +.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "EEEE d MMM  yyyy"

        return dateFormatter.string(from: Date())

    }
}
