//
//  ViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 11/01/2022.
//

import UIKit

//MARK: Extension for UITextField
extension ExchangeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var realAmount = euroAmount.text! + string
        
        if string.count == 0 && range.length > 0 { //si on supprime quelque chose
            realAmount.remove(at: realAmount.index(before: realAmount.endIndex)) //retire la derniere lettre (before index = avant dernier index car le dernier est out of range)
            guard realAmount != "" else { //on regarde si il est vide ou pas
                euroAmount.text = "1" // si il est vide on rajoute quelque chose
                return euroAmount.text == "1"
            }
            convertCalculExchange(realAmount)
            return true
        } else  {
            let maxAmount = 6
            let currentAmount: NSString = (realAmount) as NSString
            let newAmount: NSString = currentAmount.replacingCharacters(in: range, with: string) as NSString //take the string charact mount
            convertCalculExchange(realAmount)
            return newAmount.length <= maxAmount //check if the max amount is hit
        }
    }
}
