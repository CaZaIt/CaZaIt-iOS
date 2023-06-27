//
//  Map2View.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/09.
//

import CoreLocation
import NMapsMap

class MapView: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var isFirstLocationUpdate = true
    
    var currentLatitude: CLLocationDegrees = 0.0
    var currentLongitude: CLLocationDegrees = 0.0
    
    private let topview: UIView = {
        let top = UIView()
        top.translatesAutoresizingMaskIntoConstraints = false
        top.backgroundColor = .black
        return top
    }()
    
    private let mapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "카페 위치보기"
        label.numberOfLines = 1
        return label
    }()
    
    let positions = [
        NMGLatLng(lat: 37.54847570421354, lng: 127.07263694429658), // 롬곡
        NMGLatLng(lat: 37.549548141704, lng: 127.07511854895762), // 제주몰빵
        NMGLatLng(lat: 37.550136780794496, lng: 127.07322701581906), // 유캔두잇
    ]
    
    private lazy var naverMapView: NMFMapView = {
        let mapView = NMFMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.allowsZooming = true
        mapView.logoInteractionEnabled = false
        mapView.positionMode = .direction
        mapView.allowsScrolling = true
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(self.topview)
        self.topview.addSubview(self.mapLabel)
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        setUI()
        
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("Location services are enabled")
                self.locationManager.startUpdatingLocation()
            } else {
                print("Location services are disabled")
            }
        }
        
        for position in positions {
            let marker = NMFMarker(position: position)
            marker.width = 20
            marker.height = 30
            marker.iconTintColor = .blue
            marker.mapView = self.naverMapView
        }
        
        self.topview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        self.mapLabel.snp.makeConstraints { make in
            make.center.equalTo(topview)
        }
        
        
    }
    
    func setUI() {
        self.view.addSubview(naverMapView)
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        naverMapView.topAnchor.constraint(equalTo: self.topview.bottomAnchor, constant: 0).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        
        currentLatitude = location.coordinate.latitude
        currentLongitude = location.coordinate.longitude
        
        print("Latitude: \(currentLatitude), Longitude: \(currentLongitude)")
        
        
        if isFirstLocationUpdate {
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLatitude, lng: currentLongitude))
            cameraUpdate.animation = .none
            naverMapView.moveCamera(cameraUpdate)
            
            isFirstLocationUpdate = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}
