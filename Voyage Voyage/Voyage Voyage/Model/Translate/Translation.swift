//
//  Translation.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

class Translation {
    weak var delegate: TranslateDelegate?
    
    func getBaseLang(_ lang: String) {
        let langCut = lang.cutString
        let baseLang = langCut.first!
        let langAcronym = String(baseLang.uppercased())
        let langageDetected = "Langage Detected: " + langAcronym
        delegate!.baseLangageDelegate(langageDetected)
    }
    
    func getTranslatedText(_ text: [String]) {
        let newText = text[0]
        delegate?.translatedTextView(newText)
    }
    
    func modifyText(_ text: String) {
        Translate.textTranslate = text.withReplacedCharacters(" ", by: "%20")
    }
}

protocol TranslateDelegate: NSObject {
    func baseLangageDelegate(_ lang: String)
    func translatedTextView(_ text: String)
}
