//
//  PolicyViewController.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/16.
//

import UIKit
import SnapKit

class PolicyViewController: UIViewController, UIGestureRecognizerDelegate {

    private let navigationBarAppearance : UINavigationBarAppearance = {
        let navigationBar = UINavigationBarAppearance()
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.shadowColor = UIColor.clear // 기존 그림자 색상 유지
        navigationBar.configureWithTransparentBackground()
        
        return navigationBar
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(r: 255, g: 223, b: 217)
        
        return view
    }()
    
    private let locationInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "위치정보 기반 서비스 이용약관"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let locationButton: UIButton = {
        let button = UIButton()
        
        let chevronImage = UIImage(systemName: "chevron.right")
        button.setImage(chevronImage, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let dottedLineView: UIView = {
        //layer는 오토레이아웃 지정이 되지 않기때문에 view를 생성하고 그 안에 layer를 넣어서 하기 위함/
        let view = UIView()
        view.backgroundColor = .clear
        let shapeLayer = CAShapeLayer()
        // 점선 색상
        shapeLayer.strokeColor = UIColor.black.cgColor
        // 점선 두께
        shapeLayer.lineWidth = 1.5
        // 점선 패턴: 2포인트의 선, 2포인트의 공백으로 반복
        shapeLayer.lineDashPattern = [8, 8]
        // 점선의 경로
        view.layer.addSublayer(shapeLayer)
        // contentView의 bounds를 기준으로 frame 설정하여 나중에 수정하기 위해 추가
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        view.layer.addSublayer(shapeLayer)
        
        return view
    }()
    
    private let personalInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "개인정보 수집 및 이용 동의"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let personalButton: UIButton = {
        let button = UIButton()
        
        let chevronImage = UIImage(systemName: "chevron.right")
        button.setImage(chevronImage, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(personalButtonTapped), for: .touchUpInside)
        
        return button
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
        setupNavigation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupNavigation() {
        self.title = "약관 및 정책"
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
        [pinkView, locationInfoLabel, locationButton, dottedLineView, personalInfoLabel, personalButton].forEach { view.addSubview ($0) }
        
        pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        locationInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view.snp.leading).offset(34)
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerY.equalTo(locationInfoLabel.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).inset(32)
            make.width.height.equalTo(20)
        }
        
        dottedLineView.snp.makeConstraints { make in
            make.top.equalTo(locationInfoLabel.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1.5)
        }
        
        personalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(dottedLineView.snp.bottom).offset(21)
            make.leading.equalTo(view.snp.leading).offset(34)
        }
        
        personalButton.snp.makeConstraints { make in
            make.centerY.equalTo(personalInfoLabel.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).inset(32)
            make.width.height.equalTo(20)
        }
        
        // contentView에 dottedLineView 추가 후, layout이 완료되었을 때 shapeLayer의 path 설정
        // dottedLineView의 layer의 첫 번째 sublayer를 CAShapeLayer로 가져옵니다.
        let shapeLayer = dottedLineView.layer.sublayers?.first as? CAShapeLayer
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0.75)) // path의 시작점을 해당좌표로 이동합니다.
        
        // 현재 위치에서 (dottedLineView.bounds.width - 42, 0.75) 좌표까지 직선을 추가합니다.
        path.addLine(to: CGPoint(x: dottedLineView.bounds.width - 42, y: 0.75))
        
        // shapeLayer의 path를 UIBezierPath의 CGPath 표현으로 설정합니다.
        shapeLayer?.path = path.cgPath
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func locationButtonTapped() {
        let locationRuleViewController = PlaceDetailTermsView()
        navigationController?.pushViewController(locationRuleViewController, animated: true)
    }
    
    @objc func personalButtonTapped() {
        let personalInfoDetailTermsView = PersonalInfoDetailTermsView()
        navigationController?.pushViewController(personalInfoDetailTermsView, animated: true)
    }
}
