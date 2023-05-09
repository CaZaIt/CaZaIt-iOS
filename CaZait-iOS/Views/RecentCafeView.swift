//
//  RecentCafeView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/05/01.
//

import Foundation
import UIKit

class RecentCafeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 네비게이션 바 타이틀 설정
        self.title = "최근 본 매장"
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        
        
        self.view.addSubview(pinkView)
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.pinkView.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.pinkView.snp.top).inset(30)
            make.bottom.equalTo(self.pinkView.snp.bottom).inset(20)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // example number of items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true // cornerRadius가 제대로 표시되도록 설정
        
        let CafeImageView = UIImageView(frame: cell.contentView.bounds)
        CafeImageView.image = UIImage(named: "small_cafe2")
        CafeImageView.contentMode = .scaleAspectFill
        CafeImageView.clipsToBounds = true
        
        let CafeNameLabel = UILabel()
        CafeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        CafeNameLabel.text = "롬곡"
        CafeNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        CafeNameLabel.textColor = .black
        
        let DistanceLabel = UILabel()
        DistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        DistanceLabel.text = "220m"
        DistanceLabel.font = UIFont.systemFont(ofSize: 12)
        DistanceLabel.textColor = .black
        
        
        let AddressLabel = UILabel()
        AddressLabel.translatesAutoresizingMaskIntoConstraints = false
        AddressLabel.text = "서울특별시 광진구 광나루로\n375-1 2층(군자동)"
        AddressLabel.font = UIFont.systemFont(ofSize: 12)
        AddressLabel.textColor = .black
        AddressLabel.numberOfLines = 0 // 여러 줄로 표시 가능하도록 설정
        AddressLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈 설정
        
        cell.contentView.addSubview(CafeImageView)
        cell.contentView.addSubview(CafeNameLabel)
        cell.contentView.addSubview(DistanceLabel)
        cell.contentView.addSubview(AddressLabel)

        
        CafeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(213)
            make.bottom.equalToSuperview().inset(20)
        }
        
        CafeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(CafeImageView.snp.top).inset(10)
            make.leading.equalTo(CafeImageView.snp.trailing).offset(18)
        }
        
        DistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(CafeImageView.snp.top).inset(20)
            make.leading.equalTo(CafeNameLabel.snp.trailing).offset(10)
        }
        
        AddressLabel.snp.makeConstraints { make in
            make.top.equalTo(CafeNameLabel.snp.bottom).offset(20)
            make.leading.equalTo(CafeImageView.snp.trailing).offset(18)
        }
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width-40, height: 172) // example item size
    }
    
    
    //셀 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 17 // example line spacing
    }
    
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
}
