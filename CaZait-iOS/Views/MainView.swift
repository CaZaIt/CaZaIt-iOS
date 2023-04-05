//
//  ItemView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import UIKit
import SnapKit

class MainView: UIViewController {

    private let mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(r: 37, g: 68, b: 181)
        tableView.sectionHeaderTopPadding = 0 //상단 여백 해결
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        setupMainTableView()
    }
    
    func setupMainTableView() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource{
    
    //섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //섹션당 cell row 숫자의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 // 셀 높이 조정
    }
}
