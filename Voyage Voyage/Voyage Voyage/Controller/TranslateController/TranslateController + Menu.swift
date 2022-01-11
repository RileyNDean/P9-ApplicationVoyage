//
//  TranslateController + Menu.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: extension for Button menu
extension TranslateViewController {
    
     func loadMenu() {
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
            children.append(createLangMenuChildren(languages[i]))
        }
        return children
    }
    
    private func createLangMenuChildren(_ langage: String) -> UIAction {
        return UIAction(title: langage) { _
            in
            self.selectLang.setTitle(self.translateDelegate.getDestinationLang(langage), for: .normal) //modify the button name
            self.translateDelegate.getDestinationLangTranslate(langage) //modify destination language
            self.getTranslation() //get the translation
        }
    }
}
