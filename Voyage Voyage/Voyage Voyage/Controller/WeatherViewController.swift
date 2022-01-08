//
//  WeatherViewController.swift
//  Voyage Voyage
//
//  Created by Dhayan Bourguignon on 07/01/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityWeather: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        getweather()
    }
    
 
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        cityWeather.resignFirstResponder()
    }
    
    func getweather() {
        Weather.shared.getWeather { success, weather in
            
            if success, let weather = weather {
                self.updateWeather(weather: weather)
            } else {
                
            }
        }
    }
    
    func updateWeather(weather: WeatherJSONStructure) {
        guard let temp = weather.main?.temp else {return}
        tempLabel.text = "\(String(describing: Int(temp)))°"
        guard let description = weather.weather[0]?.description!.localizedCapitalized else {return}
        descriptionLabel.text = description
    }
    
    private func toggleActivityIndicator(shown: Bool) {
    
    }

}
