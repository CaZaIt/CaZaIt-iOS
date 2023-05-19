//
//  Map2View.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/09.
//

import Foundation
import NMapsMap
import CoreLocation

import UIKit

class MapView: UIViewController, CLLocationManagerDelegate {
    
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
    
    // 화양리 고정좌표(세종대 집현관을 중심기준으로)
    let initialPosition = NMGLatLng(lat: 37.549080572141555, lng: 127.07361073914453)
    //15배 확대
    let zoomLevel = NMFCameraUpdate(zoomTo: 15)
    // 화양리 술집들의 위치 설정
    let positions = [
        NMGLatLng(lat: 37.54847570421354, lng: 127.07263694429658), // 롬곡
        NMGLatLng(lat: 37.549548141704, lng: 127.07511854895762), // 제주몰빵
        NMGLatLng(lat: 37.550136780794496, lng: 127.07322701581906), // 유캔두잇
    ]
    
    private lazy var naverMapView: NMFMapView = {
        let mapView = NMFMapView() // 지도 객체 생성
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.allowsZooming = true // 줌 가능
        mapView.logoInteractionEnabled = false // 로고 터치 불가능
        mapView.allowsScrolling = true // 스크롤 가능
        mapView.moveCamera(NMFCameraUpdate(scrollTo: initialPosition,zoomTo: 16)) // 화양리로 시작좌표 설정 && 줌 확대 16배
        return mapView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.view.addSubview(self.topview)
        self.topview.addSubview(self.mapLabel)
        
        
        setUI()
        
        //마커 생성 및 설정
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
        // 슈퍼뷰에 지도 뷰를 서브뷰로 넣어줌
        self.view.addSubview(naverMapView)
        
        // constraints 사용하기 위함
        naverMapView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints 세팅
        naverMapView.topAnchor.constraint(equalTo: self.topview.bottomAnchor, constant: 0).isActive = true
        naverMapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        naverMapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        naverMapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 밝은 배경색일 경우에는 .darkContent
    }


    
}
