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
    private var allCafeData: AllCafeResponse? //MainView에서 날라온 정보를 저장합니다.
    
    private let checkCafeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoM00-Bold", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.text = "카페 확인하기"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let cafeListSettingButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 15.5
        button.clipsToBounds = true //해당 뷰의 bounds 밖으로 넘치는 콘텐츠를 잘라내서 보여줄지 여부를 결정
        button.setImage(UIImage(named:"tune"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    private let cafeListSettingLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "AppleSDGothicNeoM00-Bold", size: 14)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.text = "거리순"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //스크롤 방향은 수직
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)//collectionView와 collectionViewCell사이의 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //수평 스크롤 인디게이터를 보이지 않게 함
        collectionView.showsVerticalScrollIndicator = false //수직 스크롤 인디게이터를 보이지 않게 함
        collectionView.isScrollEnabled = false //collectionView의 스크롤을 없앤다. tableView의 스크롤만으로 이동하기 위해
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupMainTableViewCafeCell()
        
        collectionView.register(CafeListCollectionViewCell.self, forCellWithReuseIdentifier: "CafeListCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.backgroundColor = .white
    }
    
    // MainView에서 날라온 정보를 저장한 뒤, 다시 콜렉션뷰를 리로드합니다.
    func configure(with data: AllCafeResponse?) {
        self.allCafeData = data
        self.collectionView.reloadData()
    }
    
    func setupMainTableViewCafeCell() {
        contentView.addSubview(checkCafeLabel)
        
        checkCafeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(11.5)
            make.leading.equalTo(contentView.snp.leading).offset(23.5)
        }
        
        contentView.addSubview(cafeListSettingButton)
        
        cafeListSettingButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(292.5)
            make.width.equalTo(31)
            make.height.equalTo(31)
        }
        
        contentView.addSubview(cafeListSettingLabel)
        
        cafeListSettingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cafeListSettingButton.snp.centerY)
            make.leading.equalTo(cafeListSettingButton.snp.trailing).offset(7)
        }
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(45)
            make.leading.equalTo(contentView.snp.leading).offset(12.5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12.5)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculateCellHeight() -> CGFloat {
        let cellCount : CGFloat = 10 //collectionCell의 갯수
        let rowCount : CGFloat = (cellCount/2) + (cellCount.truncatingRemainder(dividingBy: 2))//collectionView의 Row의 갯수
        let cellHeight : CGFloat = 50 + rowCount * (15 + 15 + 276) //MainTableViewCafeCell의 높이 TitleLabel의 높이 50 + collectionViewCell의 row * (cell의 상단여백 + Celld의 하단여백 + cell의 높이)
        
        return cellHeight
    }
}

extension MainTableViewCafeCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // collectionView 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //통신에서 저장된 변수를 통해 cell 갯수를 정합니다.
        if let count = self.allCafeData?.data[0].count {
            return count
        } else {
            return 0
        }
    }
    
    // collectionView 셀 생성 및 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CafeListCollectionViewCell", for: indexPath) as! CafeListCollectionViewCell
        //통신에서 날라온 정보를 이용해서 콜렉션 뷰 셀에 데이터를 전달합니다.
        if let cafeInfo = self.allCafeData?.data[0][indexPath.row]{
            cell.configure(with: cafeInfo)
        }
        
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
