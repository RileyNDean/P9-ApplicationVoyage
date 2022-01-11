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
            translatedText.text = ""
            translateDelegate.modifyText(textTranslated)
            getTranslation()
            return true
        }
    }
}

extension TranslateViewController {
    
    private func loadMenu() {
        let langMenu = createLangMenu()
        let menuLanguage = UIMenu(title: "Select Language", options: .displayInline, children: langMenu)
        selectLang.menu = menuLanguage
        selectLang.showsMenuAsPrimaryAction = true
        selectLang.isContextMenuInteractionEnabled = true
    }
    
    private func createLangMenu() -> [UIAction] {
        let languages = translateDelegate.langs
        var children = [UIAction]()
        for i in 0..<languages.count {
            children.append(createLangAction(languages[i]))
        }
        return children
    }
    
    private func createLangAction(_ langage: String) -> UIAction {
        return UIAction(title: langage) { _
            in
            self.selectLang.setTitle(self.translateDelegate.getDestinationLang(langage), for: .normal)
            self.translateDelegate.getDestinationLangTranslate(langage)
            self.getTranslation()
        }
    }
}
