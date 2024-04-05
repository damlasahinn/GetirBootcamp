//
//  PermissionViewModel.swift
//  WeatherApp
//
//  Created by Damla Sahin on 5.04.2024.
//

import CoreLocation

class WeatherViewModel: NSObject {
    
    var onLocationAuthorizationGranted: ((CLLocation) -> Void)?
    
    private let locationManager = CLLocationManager()
    //private let weatherService: WeatherService
    
    override init() {
        //self.weatherService = WeatherService()
        super.init()
        self.locationManager.delegate = self
    }
   
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            //TODO: enable users location
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            //TODO: izinleri değiştirme yönlendirme
            break
        default:
            print(CLLocationManager.authorizationStatus())
            break
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherData?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=29f91bca695eb51f98d6624fd873639a&units=metric"

        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let json = String(data: data, encoding: .utf8) {
                print("API Yanıtı: \(json)")
            }
            
            let weatherData = try? JSONDecoder().decode(WeatherData.self, from: data)
            completion(weatherData)
        }.resume()
    }
}
extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == .authorizedAlways {
            onLocationAuthorizationGranted?(location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

