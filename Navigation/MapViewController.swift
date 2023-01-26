//
//  MapViewController.swift
//  Navigation
//
//  Created by Иван Могутов on 17.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    private lazy var routeButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Построить маршрут ", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(showRoute), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearPinsButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Убрать пины ", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(clearPins), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapTypeButton1: UIButton = {
        let button = UIButton()
        button.setTitle(" Схема ", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(standardMapType), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapTypeButton2: UIButton = {
        let button = UIButton()
        button.setTitle(" Спутник ", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(satelliteMapType), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapTypeButton3: UIButton = {
        let button = UIButton()
        button.setTitle(" Гибрид ", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(hybridMapType), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsScale = true
        
        mapView.showsUserLocation = true
        
        let pointsOfInterestFilter = MKPointOfInterestFilter()
        mapView.pointOfInterestFilter = pointsOfInterestFilter
        
        return mapView
    }()
    
    private lazy var myAnnotations = [MKPointAnnotation]()
    private lazy var myWaypoints = [CLLocation]()
    private lazy var pointOfDestination = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addWaypoint(longGesture:)))
        mapView.addGestureRecognizer(longGesture)
        longGesture.minimumPressDuration = 2.0
        
        findUserLocation()
    }
    
    @objc private func addWaypoint(longGesture: UIGestureRecognizer) {
        
        let touchPoint = longGesture.location(in: mapView)
        let wayCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: wayCoords.latitude, longitude: wayCoords.longitude)
        pointOfDestination = location.coordinate
        
        let wayAnnotation = MKPointAnnotation()
        wayAnnotation.coordinate = wayCoords
        wayAnnotation.title = "waypoint"
        myAnnotations.append(wayAnnotation)
        mapView.addAnnotation(wayAnnotation)
        print(myAnnotations)
    }
    
    @objc private func showRoute() {
        
        let coord1 = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0 , longitude: locationManager.location?.coordinate.longitude ?? 0 )
        let coord2 = pointOfDestination
        showRouteOnMap(pickupCoordinate: coord1, destinationCoordinate: coord2)
    }
    
    private func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            if let route = unwrappedResponse.routes.first {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
    
    @objc private func standardMapType() {
        mapView.mapType = .standard
    }
    
    @objc private func satelliteMapType() {
        mapView.mapType = .satellite
    }
    
    @objc private func hybridMapType() {
        mapView.mapType = .hybrid
    }
    
    @objc private func clearPins() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    private func setupSubviews() {
        setupMapView()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        view.addSubview(routeButton)
        view.addSubview(clearPinsButton)
        view.addSubview(mapTypeButton1)
        view.addSubview(mapTypeButton2)
        view.addSubview(mapTypeButton3)
        mapView.delegate = self
    }
    
    private func setupConstraints() {
        routeButton.translatesAutoresizingMaskIntoConstraints = false
        clearPinsButton.translatesAutoresizingMaskIntoConstraints = false
        mapTypeButton1.translatesAutoresizingMaskIntoConstraints = false
        mapTypeButton2.translatesAutoresizingMaskIntoConstraints = false
        mapTypeButton3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            routeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            routeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            clearPinsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            clearPinsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapTypeButton1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mapTypeButton1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapTypeButton2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mapTypeButton2.leadingAnchor.constraint(equalTo: mapTypeButton1.trailingAnchor, constant: 10),
            mapTypeButton3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mapTypeButton3.leadingAnchor.constraint(equalTo: mapTypeButton2.trailingAnchor, constant: 10)
        ])
    }
    
    private func findUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 100_000,
                longitudinalMeters: 100_000)
            
            mapView.setRegion(region, animated: false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle failure to get a user’s location
    }
}
