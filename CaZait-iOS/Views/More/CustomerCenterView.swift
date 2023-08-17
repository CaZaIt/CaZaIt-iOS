//
//  CustomerCenterView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/08/01.
//

import UIKit
import SnapKit

class CustomerCenterView: UIViewController, UIGestureRecognizerDelegate {
    
    private let navigationBarAppearance : UINavigationBarAppearance = {
        let navigationBar = UINavigationBarAppearance()
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.shadowColor = UIColor.clear // 기존 그림자 색상 유지
        navigationBar.configureWithTransparentBackground()
        
        return navigationBar
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "이메일"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "kazait123@kazait.com"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let numberTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "고객센터 번호"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular) //위에 글씨체가 어색해서 임시로 추가
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.text = "010-1234-5678"
        label.numberOfLines = 1
        
        return label
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
    
    private let pinkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        self.view.backgroundColor = .black
        setupNavigation()
        setupLayout()
    }
    
    func setupNavigation() {
        self.title = "고객센터"
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
        [pinkView, emailTitleLabel, emailLabel, numberTitleLabel, numberLabel, dottedLineView].forEach { view.addSubview ($0) }
        
        pinkView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(47)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        dottedLineView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(1.5)
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
        
        numberTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dottedLineView.snp.bottom).offset(21)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(numberTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(view.snp.leading).offset(39)
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
}
