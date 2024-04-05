//
//  ViewController.swift
//  WeatherApp
//
//  Created by Damla Sahin on 5.04.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var weatherVM = WeatherViewModel()
    
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherVM.checkLocationServices()
        
        weatherVM.onLocationAuthorizationGranted = { [weak self] location in
            print(location.coordinate.latitude)
            self?.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
        }
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        weatherVM.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] weatherData in
            DispatchQueue.main.async {
                if let weatherData = weatherData {
                    self?.updateUI(weatherData: weatherData)
                }
            }
        }
    }
   
    func updateUI(weatherData: WeatherData) {
        degreeLabel.text = "\(Int(weatherData.main.temp))°"
        cityLabel.text = weatherData.name
        
        windSpeedLabel.text = "Wind Speed: \(weatherData.wind.speed) m/s"
        cloudinessLabel.text = "Clouds: \(weatherData.clouds.all)%"
        countryLabel.text = "\(weatherData.sys.country)"
        
        // Convert sunrise and sunset UNIX timestamps to readable format
        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(weatherData.sys.sunrise))
        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(weatherData.sys.sunset))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .none
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

         sunriseLabel.text = "Sunrise: \(dateFormatter.string(from: sunriseDate))"
         sunsetLabel.text = "Sunset: \(dateFormatter.string(from: sunsetDate))"
    }

}

