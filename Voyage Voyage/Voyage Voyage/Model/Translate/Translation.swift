//
//  Translation.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 10/01/2022.
//

import Foundation

class Translation {
    weak var delegate: TranslateDelegate?
    var langs = ["English - EN", "Russian - RU", "French - FR", "Japanese - JA"]
    
    func getBaseLang(_ lang: String) {
        let langCut = lang.cutString
        let baseLang = langCut.first!
        let langAcronym = String(baseLang.uppercased())
        let langageDetected = "Langage Detected: " + langAcronym
        delegate!.baseLangageDelegate(langageDetected)
    }
    
    func getDestinationLang(_ lang: String) -> String {
        let langCut = lang.cutString
        let baseLang = langCut.last!
        let langAcronym = String(baseLang.uppercased())
        return langAcronym
    }
    
    func getDestinationLangTranslate(_ lang: String){
        let langCut = lang.cutString
        let baseLang = langCut.last!
        let langAcronym = String(baseLang.lowercased())
        Translate.langDestination = langAcronym
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
