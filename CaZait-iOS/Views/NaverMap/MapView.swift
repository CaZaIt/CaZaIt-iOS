//
//  Map2View.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/09.
//

import NMapsMap
import SnapKit

class MapView: UIViewController, CLLocationManagerDelegate { // 내위치가 시작좌표인 클래스
    
    private let congestionMapping: [String: String] = [
        "NONE": "미등록",
        "CLOSE": "종료",
        "FREE": "여유",
        "NORMAL": "보통",
        "CROWDED": "혼잡",
        "VERYCROWDED": "매우혼잡"
    ]
    
    private var allCafeData: AllCafeResponse? //통신한 데이터를 저장하기 위한 변수입니다.
    var locationManager = CLLocationManager()
    
    var isFirstLocationUpdate = true
    
    var currentLatitude: CLLocationDegrees = 0.0
    var currentLongitude: CLLocationDegrees = 0.0
    
    private var markers: [NMFMarker] = []
    
    let markerImage = UIImage(named: "marker")
    
    private let topview: UIView = {
        let top = UIView()
        
        top.backgroundColor = .black
        return top
    }()
    
    private let mapLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "카페 위치보기"
        label.numberOfLines = 1
        return label
    }()
    
    private let customView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
        view.isHidden = true
        
        return view
    }()
    
    private let cafeNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "롬곡"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        
        label.text = "서울특별시 광진구 광나루로 375-1 2층(군자동)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
    }()
    
    private let congestionView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private let congestionLabel: UILabel = {
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
        
        mapView.allowsZooming = true
        mapView.logoInteractionEnabled = false
        mapView.positionMode = .direction
        mapView.allowsScrolling = true
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Location Manager 설정
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        getAllCafeInfoData()
        setupLayout()
        
        // 뷰에 터치 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        naverMapView.addGestureRecognizer(tapGesture)
        
        // 위치 업데이트 시작
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("Location services are enabled")
                self.locationManager.startUpdatingLocation()
            } else {
                print("Location services are disabled")
            }
        }
        
    
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: naverMapView)

        // 마커를 찾아서 가져옴
        let tappedMarkers = naverMapView.pickAll(location, withTolerance: 10)

        if tappedMarkers.isEmpty {
            // 마커가 아닌 다른 곳을 클릭한 경우
            customView.isHidden = true
        } else {
            if let marker = tappedMarkers.first as? NMFMarker,
               let index = markers.firstIndex(of: marker),
               let cafe = allCafeData?.data[0][index] {
                cafeNameLabel.text = cafe.name
                addressLabel.text = cafe.address
                congestionLabel.text = congestionMapping[cafe.congestionStatus]
                // 여기에 추가적인 커스텀뷰의 내용을 업데이트하는 코드를 작성하세요
            }
            customView.isHidden = false
        }
    }
    
    func getAllCafeInfoData() {
        
        AllCafeService.shared.getAllCafeInfo(longitude : String(currentLongitude), latitude : String(currentLatitude), sort : "distance", limit : "0") { response in
            
            switch response {
                
            case .success(let data):
                guard let listData = data as? AllCafeResponse else {return}
                self.allCafeData = listData //통신한 데이터를 변수에 저장하고
                self.makeMarkers()
                
                
                // 실패할 경우에 분기처리는 아래와 같이 합니다.
            case .requestErr :
                print("requestErr")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serveErr")
            default:
                print("networkFail")
            }
        }
    }
    
    func makeMarkers() {
        // 마커 생성 및 설정
        if let cafeData = allCafeData?.data[0] {
            for cafe in cafeData {
                if let latitude = Double(cafe.latitude), let longitude = Double(cafe.longitude) {
                    let marker = NMFMarker(position: NMGLatLng(lat: latitude, lng: longitude))
                    marker.width = 40
                    marker.height = 50
                    marker.iconImage = NMFOverlayImage(image: markerImage!)
                    marker.mapView = naverMapView
                    markers.append(marker)
                }
            }
        }
        
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            if let marker = overlay as? NMFMarker {
                if let index = self?.markers.firstIndex(of: marker) {
                    let cafe = self?.allCafeData?.data[0][index]
                    self?.cafeNameLabel.text = cafe?.name ?? ""
                    self?.addressLabel.text = cafe?.address ?? ""
                    self?.congestionLabel.text = cafe?.congestionStatus ?? ""
                    
                    self?.customView.isHidden = false
                } else {
                    self?.customView.isHidden = true
                }
            }
            return true
        }
        
        for marker in markers {
            marker.touchHandler = handler
        }
        
    }

    
    func setupLayout() {
        view.addSubview(topview)
        topview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
        topview.addSubview(mapLabel)
        mapLabel.snp.makeConstraints { make in
            make.center.equalTo(topview)
        }
        
        view.addSubview(naverMapView)
        
        naverMapView.snp.makeConstraints { make in
            make.top.equalTo(topview.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        naverMapView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.bottom.equalTo(naverMapView.snp.bottom).inset(30)
            make.width.equalTo(284)
            make.height.equalTo(116)
            make.centerX.equalTo(naverMapView.snp.centerX)
        }
        
        customView.addSubview(cafeNameLabel)
        cafeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.top).offset(12)
            make.leading.equalTo(customView.snp.leading).offset(20)
        }
        
        customView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(customView.snp.leading).offset(20)
        }
        
        customView.addSubview(congestionView)
        congestionView.snp.makeConstraints { make in
            make.bottom.equalTo(customView.snp.bottom).inset(14)
            make.centerX.equalTo(customView.snp.centerX)
            make.width.equalTo(245)
            make.height.equalTo(31)
        }
        
        congestionView.addSubview(congestionLabel)
        congestionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(congestionView.snp.centerX)
            make.centerY.equalTo(congestionView.snp.centerY)
        }
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
