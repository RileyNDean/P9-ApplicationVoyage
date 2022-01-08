//
//  MoneyViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class MoneyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
    
    
    func testmONEY() {
        MoneyTrade.shared.getMoney { success, money in
            if success, let money = money {
              
            }
            else {
                print("erreur?")
            }
        }
    }

    @IBAction func testButtonmONEY(_ sender: UIButton) {
        testmONEY()
    }
}
