//
//  MoreView.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import UIKit

class MoreView: UIViewController{
    
    let table = UITableView()
    let testArr = ["공지사항", "계정관리","고객센터","약관 및 정책"]
    
    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1.0, green: 0.87, blue: 0.85, alpha: 1.0)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "더보기"
        label.numberOfLines = 1
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        view.addSubview(whiteView)
        whiteView.addSubview(pinkView)
        whiteView.addSubview(moreLabel)
        
        
        self.whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.whiteView.snp.top)
            make.height.equalTo(100)
        }
        
        self.moreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(30)
        }
        
        table.delegate = self
        table.dataSource = self
                
        attribute()
        layout()
    }
    
    func layout() {
            whiteView.addSubview(table)
            table.translatesAutoresizingMaskIntoConstraints = false
            table.topAnchor.constraint(equalTo: pinkView.bottomAnchor, constant: 40).isActive = true
            table.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 0).isActive = true
            table.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 0).isActive = true
            table.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: 0).isActive = true
        }
    func attribute() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension MoreView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as UITableViewCell
        
        lazy var imgView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = UIImage(systemName: "sun.max")
            view.tintColor = UIColor(r: 255, g: 115, b: 91)
            return view
        }()
        cell.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(21.87)
            make.height.equalTo(27.33)
            make.left.equalToSuperview().inset(36.47)
        }
        cell.textLabel?.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imgView.snp.right).offset(24.67)
        }
        
        cell.textLabel?.text = testArr[indexPath.row]
        cell.textLabel?.textColor = UIColor(r: 255, g: 115, b: 91)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor(r: 255, g: 115, b: 91)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected row text
        let selectedRow = testArr[indexPath.row]
        
        // Check if the selected row is "공지사항"
        if selectedRow == "공지사항" {
            // Create an instance of the "NoticeViewController" and push it
            let noticeViewController = NoticeView()
            navigationController?.pushViewController(noticeViewController, animated: true)
        }
        
        if selectedRow == "고객센터" {
            // Create an instance of the "NoticeViewController" and push it
            let customerCenterView = CustomerCenterView()
            navigationController?.pushViewController(customerCenterView, animated: true)
        }
        
        if selectedRow == "약관 및 정책" {
            let policyViewController = PolicyViewController()
            navigationController?.pushViewController(policyViewController, animated: true)
        }
        
        // Deselect the row to remove the selection highlight after pushing the new view.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

