//
//  TranslateController + TextView.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: extension for textview delegate
extension TranslateViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            let textForTranslate = textView.text!
            getTranslation(textForTranslate)
        } else {
            translatedText.text = ""
        }
    }
}
