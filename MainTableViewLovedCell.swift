//
//  MainTableViewCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/05.
//

import UIKit
import SnapKit

class MainTableViewLovedCell: UITableViewCell {

    //이동하려는 viewController가 navigationController 내에서 push될 수 있도록 navigationController를 추가
    weak var navigationController: UINavigationController?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //스크롤 방향 수평으로 설정
        layout.sectionInset = UIEdgeInsets(top: 10, left: 21, bottom: 10, right: 21) //collectionView와 collectionViewCell사이의 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //수평 스크롤 인디게이터를 보이지 않게 함
        collectionView.backgroundColor = .green
        return collectionView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200) // collectionView 높이 설정
        }
        
        // collectionView에 사용될 셀 등록
        collectionView.register(LovedCollectionViewCell.self, forCellWithReuseIdentifier: "LovedCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MainTableViewLovedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // collectionView 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // collectionView 셀 생성 및 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LovedCollectionViewCell", for: indexPath) as! LovedCollectionViewCell
        
        
        return cell
    }
    
    // collectionView 셀 크기 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 131, height: 174)
    }
    
    // collectionView 셀과 셀 사이 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    
    // collectionView 셀이 선택됐을 때 처리할 작업 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.item) selected")
        
        // CafeDetailView 호출
        let cafeDetailView = CafeDetailView() // CafeDetailView 초기화
        navigationController?.pushViewController(cafeDetailView, animated: true)
        
    }
    
}

