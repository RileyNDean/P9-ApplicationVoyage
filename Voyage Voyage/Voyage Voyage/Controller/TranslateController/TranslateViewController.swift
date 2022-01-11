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
    @IBOutlet weak var selectLang: UIButton!
    
    let translateDelegate = Translation()
    let errorController = ErrorController()
    
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
        loadMenu()
    }
    
    @IBAction func dissmissKeyboard(_ sender: Any) {
        baseText.resignFirstResponder()
        translatedText.resignFirstResponder()
    }
    
    func getTranslation() {
        Translate.shared.getTranslatedText {  success, text in
            if success, let text = text {
                self.translateDelegate.getBaseLang(text.lang)
                self.translateDelegate.getTranslatedText(text.text)
            } else {
                self.errorController.presentAlertTranslate(controller: self)
            }
        }
    }
}
