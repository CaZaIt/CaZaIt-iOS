//
//  AccountManagementVC.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/23.
//

import UIKit
import SnapKit

class AccountManagementVC: UIViewController, UIGestureRecognizerDelegate {

    private let textArr = ["비밀번호 변경", "닉네임 변경", "계정 탈퇴"]
    private let imageArr = ["key.horizontal", "person.text.rectangle", "person.fill.xmark"]
    
    private let navigationBarAppearance : UINavigationBarAppearance = {
        let navigationBar = UINavigationBarAppearance()
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.shadowColor = UIColor.clear // 기존 그림자 색상 유지
        navigationBar.configureWithTransparentBackground()
        
        return navigationBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.showsVerticalScrollIndicator = false //수직 스크롤 인디게이터를 보이지 않게 함
        tableView.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        tableView.sectionHeaderTopPadding = 0 //상단 패딩을 0으로 지정한다.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false //스크롤 불가
        
        return tableView
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigation()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func setupNavigation() {
        self.title = "계정관리"
        //손가락 옆으로 미는 제스쳐 작동
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

    func setupLayout() {
        view.addSubview(pinkView)
        pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.equalToSuperview().inset(22)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
}

extension AccountManagementVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as UITableViewCell
        
        lazy var imgView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.image = UIImage(systemName: imageArr[indexPath.row])
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
        
        cell.textLabel?.text = textArr[indexPath.row]
        cell.textLabel?.textColor = UIColor(r: 255, g: 115, b: 91)
        cell.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        cell.selectionStyle = .none
        
        tableView.separatorColor = UIColor(r: 255, g: 115, b: 91)
        
        return cell
    }
    
}

extension AccountManagementVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRow = textArr[indexPath.row]
        
        if selectedRow == "비밀번호 변경" {
            let changePasswordVC = ChangePasswordVC()
            navigationController?.pushViewController(changePasswordVC, animated: true)
        } else if selectedRow == "닉네임 변경" {
            let changeNickNameVC = ChangeNickNameVC()
            navigationController?.pushViewController(changeNickNameVC, animated: true)
        } else if selectedRow == "계정 탈퇴" {
            let alertController = UIAlertController(title: "정말 계정을 탈퇴하시겠습니까?", message: "계정 탈퇴 시 저장된 정보는 복구되지 않습니다.", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (_) in
                self.deleteUserInfo()
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .default) { (_) in
                self.dismiss(animated: true, completion: nil) //경고창 닫기
            }
            
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            // 경고창을 표시합니다.
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func deleteUserInfo() {
        DeleteAccountService.shared.getDeleteAccountInfo() { response in
            
            switch response {
                
            case .success(let data):
                guard let listData = data as? DeleteAccountResponse else {return}
                let alert = UIAlertController(title: "계정 탈퇴에 성공했습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    UserDefaults.standard.removeObject(forKey: "userId")
                    KeyChain.delete(key: "accessToken")
                    KeyChain.delete(key: "refreshToken")
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            default:
                let alert = UIAlertController(title: "계정 탈퇴 중 오류가 발생했습니다.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


