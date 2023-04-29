//
//  ItemView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/02.
//

import UIKit
import SnapKit

class MainView: UIViewController {

    let mainTopSearchView = MainTopSearchView()
    
    private let whiteView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false //수직 스크롤 인디게이터를 보이지 않게 함
        tableView.backgroundColor = .white
        tableView.sectionHeaderTopPadding = 0 //상단 패딩을 0으로 지정한다.
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewLovedCell.self, forCellReuseIdentifier: "MainTableViewLovedCell")
        mainTableView.register(MainTableViewCafeCell.self, forCellReuseIdentifier: "MainTableViewCafeCell")
        
        setupMainTableView()
    }
    
    func setupMainTableView() {
        view.addSubview(whiteView)
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        whiteView.addSubview(mainTopSearchView)
        
        mainTopSearchView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(99)
        }
        
        whiteView.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTopSearchView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(whiteView.snp.bottom)
        }
    }
    //상단의 시계가 흰색으로 표시되게 하기 위해서 추가하는 코드입니다.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 밝은 배경색일 경우에는 .darkContent
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource{
    
    //mainTableView의 섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //mainTableView의 각 섹션 마다 cell row 숫자의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    //mainTableView의 각 센션 마다 사용할 cell의 종류
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewLovedCell", for: indexPath) as! MainTableViewLovedCell
            cell.navigationController = navigationController
            // 첫 번째 섹션에서 사용할 셀 구성
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCafeCell", for: indexPath) as! MainTableViewCafeCell
            cell.navigationController = navigationController
            // 두 번째 섹션에서 사용할 셀 구성
            return cell
        }
    }

    //mainTableViewCell의 높이를 지정한다.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 245
        } else { //section1의 경우 수직방향 collectionView이므로 cell의 갯수에 따라 높이가 다르게 지정된다.
            let cell = MainTableViewCafeCell()
            let cellHeight = cell.calculateCellHeight()
            return cellHeight
        }
    }
    
    
}
