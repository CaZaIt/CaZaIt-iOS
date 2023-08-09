//
//  RecentCafeView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/01.
//

import Foundation
import UIKit

class RecentCafeView: UIViewController {
    
    private var recentCafes = [RecentModel]()
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical  // 수평 또는 수직 스크롤 설정
        flowLayout.sectionInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0) // 상하좌우 패딩 설정
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let navigationBarAppearance : UINavigationBarAppearance = {
        let navigationBar = UINavigationBarAppearance()
        
        navigationBar.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1) // 기존 배경 색상 유지
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.shadowColor = UIColor.clear // 기존 그림자 색상 유지
        navigationBar.configureWithTransparentBackground()
        
        return navigationBar
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
        loadRecentCafesFromUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        collectionView.register(RecentCafeCollectionViewCell.self, forCellWithReuseIdentifier: "RecentCafeCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        self.view.addSubview(pinkView)
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.pinkView.addSubview(collectionView)
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        setupNavigation()
    }
    
    func setupNavigation() {
        self.title = "최근 본 매장"
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    // 새로운 카페 정보를 추가
    func addRecentCafe(cafe: RecentModel) {
        loadRecentCafesFromUserDefaults()
        if let index = recentCafes.firstIndex(of: cafe) {
            // 이미 존재하는 카페면 배열에서 제거하고 다시 맨 앞에 추가하여 최근 본 것으로 갱신
            recentCafes.remove(at: index)
        }
        recentCafes.insert(cafe, at: 0)
        print("recentCafe 출력됩니다")
        print(recentCafes)
        
        saveRecentCafesToUserDefaults()
    }
    
    // 저장
    func saveRecentCafesToUserDefaults() {
        let encodedData = try? JSONEncoder().encode(recentCafes)
        UserDefaults.standard.set(encodedData, forKey: "recentCafes")
    }

    // 불러오기
    func loadRecentCafesFromUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: "recentCafes") {
            if let decodedCafes = try? JSONDecoder().decode([RecentModel].self, from: encodedData) {
                recentCafes = decodedCafes
            }
        }
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
}

extension RecentCafeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // collectionView 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentCafes.count
    }
    
    // collectionView 셀 생성 및 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCafeCollectionViewCell", for: indexPath) as! RecentCafeCollectionViewCell
        cell.configure(with: recentCafes[indexPath.row])
        
        return cell
    }
    
    // collectionView 셀 크기 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width-40, height: 172) // example item size
    }
    
    // collectionView 셀과 셀 사이 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }

    
}


extension RecentCafeView: UIGestureRecognizerDelegate { }
