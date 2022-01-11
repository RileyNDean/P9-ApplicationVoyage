//
//  WeatherViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityWeather: UITextField!
    
    let errorController = ErrorController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        cityWeather.delegate = self
        getWeather()
    }
 
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        cityWeather.resignFirstResponder()
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if cityWeather.text == nil {
            cityWeather.returnKeyType = .default
        } else {
            cityWeather.returnKeyType = .search
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if cityWeather.returnKeyType == .default {
            cityWeather.resignFirstResponder()
        }
        else if cityWeather.returnKeyType == .search {
            Weather.citySearched = textField.text!
            getWeather()
            cityWeather.resignFirstResponder()
        }
        return false
    }
    
    func getWeather() {
        Weather.shared.getWeather { success, weather in
            if success, let weather = weather {
                self.updateWeather(weather: weather)
            } else {
                self.errorController.presentAlertWeather(controller: self)
            }
        }
    }

    func updateWeather(weather: WeatherData) {
        guard let temp = weather.temp else {return}
        tempLabel.text = "\(String(describing: Int(temp)))°" //update temperature
        guard let description = weather.description?.localizedCapitalized else {return}
        descriptionLabel.text = description //update the description
        guard let weatherIconName = weather.icon else {return}
        weatherImage.image = UIImage(named: "\(weatherIconName)")! //change background image with the weather
    }
}

