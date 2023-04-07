//
//  RecentPlaceView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/07.
//

import Foundation
import UIKit

class RecentPlaceView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        // 셀 등록
        tableView.register(RecentPlaceViewCell.self, forCellReuseIdentifier: "MyCell")

        view.addSubview(tableView)

        // 제약 조건 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

    // 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    // 셀의 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! RecentPlaceViewCell

        // 셀의 내용 설정
        cell.myLabel.text = "Label \(indexPath.row)"
        cell.myImageView.image = UIImage(named: "small_cafe2")

        return cell
    }
}
