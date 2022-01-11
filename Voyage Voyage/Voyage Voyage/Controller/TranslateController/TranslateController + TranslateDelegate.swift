//
//  TranslateController + TranslateDelegate.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: entension for TranslateDelegate
extension TranslateViewController: TranslateDelegate {
    func translatedTextView(_ text: String) {
        translatedText.text = "" //put translatedText text at "" for update after
        translatedText.text = text
    }
    
    func baseLangageDelegate(_ lang: String) {
        langDetected.text = lang
    }
}
