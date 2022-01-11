//
//  Translate.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation


class Translate {
    static var shared = Translate()
    private init() {}
    
    private static let baseLangageURL = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/detect?")!
    private static let translateURL = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?")!
    private static let translateAPIKey = "key=trnsl.1.1.20220110T102058Z.105f566fbff69b26.da39ca19cc81893c4dda2149efeb28fcbd875c6b"
    private var task: URLSessionDataTask?
    
    static var translatedText = "J'aime le chocolat"
    static var destinationLanguage = "en"
    
    private var baseLangSession = URLSession(configuration: .default)
    private var translatedTextSession = URLSession(configuration: .default)
    
    init(baseLangSession: URLSession, translatedTextSession: URLSession) {
        self.baseLangSession = baseLangSession
        self.translatedTextSession = translatedTextSession
    }
}


extension Translate {
    
    func getTranslatedText(callback: @escaping (Bool, TranslatedText?) -> Void) {
        let request = createTranslateRequest()
        
        task?.cancel()
        
        task = translatedTextSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslatedText.self, from: data) else {
                    callback(false,nil)
                    return
                }
                return callback(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    private func createTranslateRequest() -> URLRequest {
        var request = URLRequest(url: Translate.translateURL)
        request.httpMethod = "POST"
        
        let option = "fr"
        let lang = Translate.destinationLanguage
        let text = Translate.translatedText
        let body = "lang=\(lang)&\(Translate.translateAPIKey)&text=\(text)&option=\(option)"
        request.httpBody = body.data(using: .utf8)
        return request
    }
}
