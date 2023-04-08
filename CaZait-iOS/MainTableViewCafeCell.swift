//
//  MainTableViewCafeCell.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/05.
//

import UIKit
import SnapKit

class MainTableViewCafeCell: UITableViewCell {
   
    weak var navigationController: UINavigationController?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //스크롤 방향은 수직
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)//collectionView와 collectionViewCell사이의 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //수평 스크롤 인디게이터를 보이지 않게 함
        collectionView.showsVerticalScrollIndicator = false //수직 스크롤 인디게이터를 보이지 않게 함
        collectionView.isScrollEnabled = false //collectionView의 스크롤을 없앤다. tableView의 스크롤만으로 이동하기 위해
        collectionView.backgroundColor = .yellow 
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(contentView.snp.leading).offset(12.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12.5)
            make.bottom.equalToSuperview()
        }
        
        collectionView.register(CafeListCollectionViewCell.self, forCellWithReuseIdentifier: "CafeListCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculateCellHeight() -> CGFloat {
        let cellCount : CGFloat = 10 //collectionCell의 갯수
        let rowCount : CGFloat = (cellCount/2) + (cellCount.truncatingRemainder(dividingBy: 2))//collectionView의 Row의 갯수
        let cellHeight : CGFloat = rowCount * (15 + 15 + 276) //collectionView의 높이 collectionViewCell의 row * (cell의 상단여백 + Celld의 하단여백 + cell의 높이)
        
        return cellHeight
    }
}

extension MainTableViewCafeCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // collectionView 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // collectionView 셀 생성 및 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CafeListCollectionViewCell", for: indexPath) as! CafeListCollectionViewCell
        
        
        return cell
    }
    
    // collectionView 셀 크기 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166, height: 276)
    }
    
    // collectionView 셀과 셀 사이 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    // collectionView 줄과 줄 사이 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    // collectionView 셀이 선택됐을 때 처리할 작업 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.item) selected")
        
        // CafeDetailView 호출
        let cafeDetailView = CafeDetailView() // CafeDetailView 초기화
        navigationController?.pushViewController(cafeDetailView, animated: true)
        
    }
    
}
