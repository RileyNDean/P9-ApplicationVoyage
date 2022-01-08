//
//  ErrorController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 08/01/2022.
//

import Foundation
import UIKit

class ErrorController {
    public func presentAlertNetwork(controller: UIViewController) {
        let alertVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    //Alert for Weather
    public func presentAlertWeather(controller: UIViewController) {
        let alertVC = UIAlertController(title: "Error", message: "Error with the City Name.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alertVC, animated: true, completion: nil)
    }
}