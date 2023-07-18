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
    
    var marker1: NMFMarker!
    var marker2: NMFMarker!
    var marker3: NMFMarker!
    
    let markerImage = UIImage(named: "marker")
    
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
    
    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
        view.isHidden = true
        return view
    }()
    
    private let CafeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "롬곡"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let AddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "서울특별시 광진구 광나루로 375-1 2층(군자동)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 1 // 여러 줄로 표시 가능하도록 설정
//        label.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈 설정
        return label
    }()
    
    private let CongestionView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let CongestionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "보통"
        label.numberOfLines = 1
        return label
    }()
    
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
        marker1.width = 40
        marker1.height = 50
        marker1.iconImage = NMFOverlayImage(image: markerImage!)
        marker1.mapView = self.naverMapView
        
        marker2 = NMFMarker(position: NMGLatLng(lat: 37.549548141704, lng: 127.07511854895762))
        marker2.width = 40
        marker2.height = 50
        marker2.iconImage = NMFOverlayImage(image: markerImage!)
        marker2.mapView = self.naverMapView
        
        marker3 = NMFMarker(position: NMGLatLng(lat: 37.55150266147334, lng: 127.07612770012503))
        marker3.width = 40
        marker3.height = 50
        marker3.iconImage = NMFOverlayImage(image: markerImage!)
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
        
        self.topview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        self.mapLabel.snp.makeConstraints { make in
            make.center.equalTo(topview)
        }
        
        self.customView.snp.makeConstraints { make in
            make.leading.equalTo(self.naverMapView.safeAreaLayoutGuide.snp.leading).inset(50)
            
            make.top.equalTo(self.naverMapView.safeAreaLayoutGuide.snp.top).inset(50)
            make.height.equalTo(100)
            make.width.equalTo(200)
        }
        
        // 마커 클릭 시 정보 창 열기/닫기
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            if let marker = overlay as? NMFMarker {
                if marker == self?.marker1 {
                    if self?.customView.isHidden == true {
                        print("마커1 클릭")
                        self?.CafeNameLabel.text = "롬곡"
                        self?.customView.isHidden = false
                    } else {
                        self?.customView.isHidden = true
                    }
                } else if marker == self?.marker2 {
                    if self?.customView.isHidden == true {
                        print("마커2 클릭")
                        self?.CafeNameLabel.text = "제주몰빵"
                        self?.customView.isHidden = false
                    } else {
                        self?.customView.isHidden = true
                    }
                } else if marker == self?.marker3 {
                    if self?.customView.isHidden == true {
                        print("마커3 클릭")
                        self?.CafeNameLabel.text = "보난자"
                        self?.customView.isHidden = false
                    } else {
                        self?.customView.isHidden = true
                    }
                }
            }
            
            
            return true
        }
        
        marker1.touchHandler = handler
        marker2.touchHandler = handler
        marker3.touchHandler = handler
        
    }

    
    func setUI() {
        self.view.addSubview(naverMapView)
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        naverMapView.topAnchor.constraint(equalTo: self.topview.bottomAnchor, constant: 0).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        self.naverMapView.addSubview(self.customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: self.naverMapView.topAnchor, constant: 500).isActive = true
        customView.leadingAnchor.constraint(equalTo: self.naverMapView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        customView.trailingAnchor.constraint(equalTo: self.naverMapView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        customView.bottomAnchor.constraint(equalTo: self.naverMapView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        self.customView.addSubview(self.CafeNameLabel)
        CafeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        CafeNameLabel.topAnchor.constraint(equalTo: self.customView.topAnchor, constant: 12).isActive = true
        CafeNameLabel.leadingAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        CafeNameLabel.trailingAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.trailingAnchor, constant: -225).isActive = true
        CafeNameLabel.bottomAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.bottomAnchor, constant: -72).isActive = true
        
        self.customView.addSubview(self.AddressLabel)
        AddressLabel.translatesAutoresizingMaskIntoConstraints = false
        AddressLabel.topAnchor.constraint(equalTo: self.customView.topAnchor, constant: 44).isActive = true
        AddressLabel.leadingAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        AddressLabel.trailingAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        AddressLabel.bottomAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        self.customView.addSubview(self.CongestionView)
        CongestionView.translatesAutoresizingMaskIntoConstraints = false
        CongestionView.topAnchor.constraint(equalTo: self.AddressLabel.bottomAnchor, constant: 1).isActive = true
        CongestionView.leadingAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        CongestionView.trailingAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        CongestionView.bottomAnchor.constraint(equalTo: self.customView.safeAreaLayoutGuide.bottomAnchor, constant: -14).isActive = true
        
        self.customView.addSubview(self.CongestionLabel)
        CongestionLabel.translatesAutoresizingMaskIntoConstraints = false
        CongestionLabel.topAnchor.constraint(equalTo: self.CongestionView.topAnchor, constant: 7).isActive = true
        CongestionLabel.leadingAnchor.constraint(equalTo: self.CongestionView.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        CongestionLabel.trailingAnchor.constraint(equalTo: self.CongestionView.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        CongestionLabel.bottomAnchor.constraint(equalTo: self.CongestionView.safeAreaLayoutGuide.bottomAnchor, constant: -7).isActive = true

        
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
