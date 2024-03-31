//
//  MapViewController.swift
//  Getir-Basic-Components
//
//  Created by Damla Sahin on 24.03.2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        checkLocationServices()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            let alertController = UIAlertController(title: "Konum Kapalı", message: "Konum kullanmak için ayarlardan açın.", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Ayarlar", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Ayarlar açıldı. \(success)")
                    })
                }
            }
            
            let cancelAction = UIAlertAction(title: "Iptal", style: .cancel, handler: nil)
            
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
            
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            print("Kullanıcı izin verdi")
            mapView.showsUserLocation = true
            trackingLocation()
            break
        case .authorizedWhenInUse:
            trackingLocation()
            break
        }
    }
    
    func trackingLocation() {
        mapView.showsUserLocation = true
        showUserLocationCenterMap()
        locationManager.startUpdatingLocation()
        lastLocation = getCenterLocation(mapView: mapView)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showUserLocationCenterMap() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getCenterLocation(mapView: MKMapView) -> CLLocation{
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geoCoder = CLGeocoder()
        guard let lastLocation = lastLocation else { return }
        
        guard center.distance(from: lastLocation) > 30 else { return }
        self.lastLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] placeMarks, error in
            guard let self else { return }
            
            if let error {
                print("HATA")
                return
            }
            
            guard let placeMark = placeMarks?.first else { return }
            let city = placeMark.locality ?? "City"
            let streetName = placeMark.thoroughfare ?? "Street"
            let streetNumber = placeMark.subThoroughfare ?? "StreetNumber"
            let neighborhood = placeMark.subLocality ?? "Neighborhood"
            let postalCode = placeMark.postalCode ?? "PostalCode"
            let country = placeMark.country ?? "Country"
            
            DispatchQueue.main.async {
                self.addressLabel.text = "Street Name: \(streetName) Street Number: \(streetNumber) Neighborhood: \(neighborhood) City: \(city) Country: \(country) Postal Code: \(postalCode)"
            }
        }
        
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
