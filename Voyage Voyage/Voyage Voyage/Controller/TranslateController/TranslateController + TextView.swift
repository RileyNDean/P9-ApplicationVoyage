//
//  TranslateController + TextView.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: extension for textview delegate
extension TranslateViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var textTranslated = baseText.text! + text
        if text.count == 0 && range.length > 0 { //if the user tap "delete" button
            textTranslated.remove(at: textTranslated.index(before: textTranslated.endIndex)) //remove last textTranslated character
            return true
        } else {
            translateDelegate.modifyText(textTranslated) //update the text for the request
            getTranslation()
            return true
        }
    }
}
