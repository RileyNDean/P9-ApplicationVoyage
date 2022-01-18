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
    var langAcronym = ""
    
    
    //Base lang for print it in the Label
    func getBaseLang(_ lang: String) {
        let langCut = lang.cutString
        let baseLang = langCut.first!
        let langAcronym = String(baseLang.uppercased())
        let langageDetected = "Langage Detected: " + langAcronym
        delegate?.baseLangageDelegate(langageDetected)
    }
    
    //upcase the acronym for print it in the button mode uppercase
    func getDestinationLang(_ lang: String) -> String {
        let langCut = lang.cutString
        let baseLang = langCut.last!
        let langAcronym = String(baseLang.uppercased()) //upcase the acronym
        return langAcronym
    }
    
    //lowercase the acronym for the request url
    func getDestinationLangTranslate(_ lang: String) {
        let langCut = lang.cutString
        let baseLang = langCut.last!
        let langAcronym = String(baseLang.lowercased()) //lowercase the acronym
        Translate.destinationLanguage = langAcronym
    }
}

protocol TranslateDelegate: NSObject {
    func baseLangageDelegate(_ lang: String)
    func translatedTextView(_ text: String)
}
