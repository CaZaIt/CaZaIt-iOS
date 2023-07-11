//
//  Map2View.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/09.
//

import CoreLocation
import NMapsMap

class MapView: UIViewController, CLLocationManagerDelegate { // 내위치가 시작좌표인 클래스
    
    var locationManager = CLLocationManager()
    
    var isFirstLocationUpdate = true
    
    var currentLatitude: CLLocationDegrees = 0.0
    var currentLongitude: CLLocationDegrees = 0.0
    var infoWindow: NMFInfoWindow?
    
    var marker1: NMFMarker!
    var marker2: NMFMarker!
    var marker3: NMFMarker!
    
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
    
//    let positions = [
//        NMGLatLng(lat: 37.54847570421354, lng: 127.07263694429658), // 롬곡
//        NMGLatLng(lat: 37.549548141704, lng: 127.07511854895762), // 제주몰빵
//        NMGLatLng(lat: 37.550136780794496, lng: 127.07322701581906), // 유캔두잇
//    ]
    
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
        
        // Location Manager 설정
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        setUI()
        
        // 마커 생성 및 설정
        marker1 = NMFMarker(position: NMGLatLng(lat: 37.54847570421354, lng: 127.07263694429658))
        marker1.width = 20
        marker1.height = 30
        marker1.iconTintColor = .blue
        marker1.mapView = self.naverMapView
        
        marker2 = NMFMarker(position: NMGLatLng(lat: 37.549548141704, lng: 127.07511854895762))
        marker2.width = 20
        marker2.height = 30
        marker2.iconTintColor = .blue
        marker2.mapView = self.naverMapView
        
        marker3 = NMFMarker(position: NMGLatLng(lat: 37.550136780794496, lng: 127.07322701581906))
        marker3.width = 20
        marker3.height = 30
        marker3.iconTintColor = .blue
        marker3.mapView = self.naverMapView
        
        // 위치 업데이트 시작
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("Location services are enabled")
                self.locationManager.startUpdatingLocation()
            } else {
                print("Location services are disabled")
            }
        }
        
        // 정보 창 설정
        infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "정보 창 내용"
        infoWindow?.dataSource = dataSource
        
        // 마커 추가
//        for position in positions {
//            let marker = NMFMarker(position: position)
//            marker.width = 20
//            marker.height = 30
//            marker.iconTintColor = .blue
//            marker.mapView = self.naverMapView
//        }
        
        self.topview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        self.mapLabel.snp.makeConstraints { make in
            make.center.equalTo(topview)
        }
        
        // 마커 클릭 시 정보 창 열기/닫기
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            if let marker = overlay as? NMFMarker {
                if marker.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    self?.infoWindow?.open(with: marker)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    self?.infoWindow?.close()
                }
            }
            return true
        }
        
        marker1.touchHandler = handler
        marker2.touchHandler = handler
        marker3.touchHandler = handler
        
        
    }
    
    // 지도를 탭하면 정보 창 닫기
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow?.close()
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
        
        // 현재 위치 업데이트
        currentLatitude = location.coordinate.latitude
        currentLongitude = location.coordinate.longitude
        
        print("Latitude: \(currentLatitude), Longitude: \(currentLongitude)")
        
        
        // 처음 위치 업데이트일 경우에만 카메라 이동
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
