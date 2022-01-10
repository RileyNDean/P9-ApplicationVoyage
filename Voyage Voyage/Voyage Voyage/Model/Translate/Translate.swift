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
    
    static var textTranslate = "hipsun es dracones"
   
    
    private var baseLangSession = URLSession(configuration: .default)
    private var textTranslateSession = URLSession(configuration: .default)
    
    init(translatelangSession: URLSession, textTranslateSession: URLSession) {
        self.baseLangSession = translatelangSession
        self.textTranslateSession = textTranslateSession
    }
    
}



extension Translate {
    
    func getTranslatedText(callback: @escaping (Bool, TextTranslate?) -> Void) {
        let request = createTranslateRequest()
        
        task?.cancel()
        
        task = textTranslateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TextTranslate.self, from: data) else {
                    //let responseString = String(data: data, encoding: .utf8)
                   // print(responseString)
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
        let lang = "en"
        let text = Translate.textTranslate
        let body = "lang=\(lang)&\(Translate.translateAPIKey)&text=\(text)&option=\(option)"
        request.httpBody = body.data(using: .utf8)
        return request
    }
}

extension Translate {
    

    
    
}





// lang=fr&key=trnsl.1.1.20220110T102058Z.105f566fbff69b26.da39ca19cc81893c4dda2149efeb28fcbd875c6b&text=i love coconut&option=en
/* //MARK: Get base langage
 extension Translate {
     
     func getBaseLang(callback: @escaping (Bool, BaseLang?) -> Void) {
         let request = createBaseLangRequest()
         
         task?.cancel()
         
         task = baseLangSession.dataTask(with: request) { (data, response, error) in
             DispatchQueue.main.async {
                 guard let data = data, error == nil else {
                     callback(false, nil)
                     return
                 }
                 guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                     callback(false, nil)
                     return
                 }
                 guard let responseJSON = try? JSONDecoder().decode(BaseLang.self, from: data) else {
                           let responseString = String(data: data, encoding: .utf8)
                           callback(false, nil)
                           return
                       }
                 return callback(true, responseJSON)
             }
         }
         
         task?.resume()
     }
     
     private func createBaseLangRequest() -> URLRequest {
         var request = URLRequest(url: Translate.baseLangageURL)
         request.httpMethod = "POST"
         
         
         let baseTextLangage = "wahrscheinlichsten"
         let body = "\(Translate.translateAPIKey)&text=\(baseTextLangage)"
         
         request.httpBody = body.data(using: .utf8)
         return request
     }
 }
 */
