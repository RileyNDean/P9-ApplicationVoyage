//
//  TranslateViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class TranslateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
    
    
    @IBAction func testgetLang(_ sender: UIButton) {
        traslate()
    }
    
    func traslate() {
        Translate.shared.getTranslatedText { success, text in
            if success, let text = text {
                print(text.text)
            }
        }
    }
}
