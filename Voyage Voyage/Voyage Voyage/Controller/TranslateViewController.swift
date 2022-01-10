//
//  TranslateViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var baseText: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var langDetected: UILabel!
    let translateDelegate = Translation()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        translateDelegate.delegate = self
        baseText.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translateDelegate.delegate = self
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        baseText.delegate = self
        overrideUserInterfaceStyle = .dark
    }
    
 
    @IBAction func dissmissKeyboard(_ sender: Any) {
        baseText.resignFirstResponder()
        translatedText.resignFirstResponder()
    }
    
    func traslate() {
        Translate.shared.getTranslatedText {  success, text in
            if success, let text = text {
                self.translateDelegate.getBaseLang(text.lang)
                self.translateDelegate.getTranslatedText(text.text)
            }
        }
    }
    
    
}

extension TranslateViewController: TranslateDelegate {
    func translatedTextView(_ text: String) {
        translatedText.text = text
    }
    
    func baseLangageDelegate(_ lang: String) {
        langDetected.text = lang
    }
    
}

extension TranslateViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var textTranslated = baseText.text! + text
        if text.count == 0 && range.length > 0 {
            textTranslated.remove(at: textTranslated.index(before: textTranslated.endIndex))
            return true
        } else {
            translateDelegate.modifyText(textTranslated)
            traslate()
            return true
        }
    }
}
