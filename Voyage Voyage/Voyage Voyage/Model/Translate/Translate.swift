//
//  Translate.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import Foundation


class Translate {
    static var shared = Translate()
    private init() {
        self.translatedTextSession = URLSession(configuration: .default)
    }
    
    private static let translateURL = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?")!
    private static let translateAPIKey = "trnsl.1.1.20220110T102058Z.105f566fbff69b26.da39ca19cc81893c4dda2149efeb28fcbd875c6b"
    private var task: URLSessionDataTask?
    
    static var destinationLanguage = "en"
    
    private var translatedTextSession: URLSession
    
    init(translatedTextSession: URLSession) {
        self.translatedTextSession = translatedTextSession
    }
}

//MARK: extension for the request
extension Translate {
    
    func getTranslatedText(_ textForTranslate: String, callback: @escaping (Bool, TranslatedText?) -> Void) {
        let request = createTranslateRequest(textForTranslate)
        
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
                guard let responseJSON = try? JSONDecoder().decode(TranslatedTextResponse.self, from: data) else {
                    callback(false,nil)
                    return
                }
                return callback(true, TranslatedText(text: responseJSON.text[0].description, lang: responseJSON.lang))
            }
        }
        task?.resume()
    }
    
    private func createTranslateRequest(_ textForTranslate: String) -> URLRequest {
        var request = URLRequest(url: Translate.translateURL)
        request.httpMethod = "POST"
        
        let lang = Translate.destinationLanguage
        let text = textForTranslate
        let body = "lang=\(lang)&key=\(Translate.translateAPIKey)&text=\(text)"
        request.httpBody = body.data(using: .utf8)
        return request
    }
}
