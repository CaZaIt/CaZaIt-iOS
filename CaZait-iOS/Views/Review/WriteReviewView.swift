//
//  WriteReviewView.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/22.
//

import UIKit
import SnapKit


class WriteReviewView: UIViewController{
    var cafeId : String?
    
    var selectedStarCount: Int = 0
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
        return view
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //카페는 어떠셨나요? 별점을 남겨주세요.
    let text1: UILabel = {
        let text1 = UILabel()
        text1.text = "카페는 어떠셨나요? 별점을 남겨주세요."
        text1.textColor = .black
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.font = .italicSystemFont(ofSize: 15)
        return text1
    }()
    
    lazy var rateView: RateView = {
        let view = RateView()
        view.delegate = self
        return view
    }()

    
    private lazy var hstackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    //카페는 어떠셨나요? 별점을 남겨주세요.
    let text2: UILabel = {
        let text2 = UILabel()
        text2.text = "다른 이용자를 위해 카페 리뷰를 남겨주세요."
        text2.textColor = .black
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.font = .italicSystemFont(ofSize: 15)
        return text2
    }()
    

    let textfield1: InsetTextField = {

        let textField = InsetTextField();

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "공백 포함 최대 50자 이내로 작성해주세요."
        textField.setPlaceholder(color: UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1))
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        //textField.setPlaceholder(color: UIColor(r: 93, g: 36, b: 36))
        textField.insetX = 47.25
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 0.363, green: 0.142, blue: 0.142, alpha: 1).cgColor

        return textField

    }()
    
    
    let placeholder = "공백 포함 최대 50자 이내로 작성해주세요."

    var activityTextView: UITextView{
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .italicSystemFont(ofSize: 14)
        text.backgroundColor = .white
        text.layer.borderWidth = 0  // 테두리 없애기
//        text.tintColor = UIColor(red: 0.363, green: 0.142, blue: 0.142, alpha: 1)
        text.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        return text

     }

    let text3: UILabel = {
        let text = UILabel()
        text.text = "0/50"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .italicSystemFont(ofSize: 14)
        return text
    }()
    
    //작성하기
    let button1: UIButton = {
        var button1 = UIButton()
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.backgroundColor = .black
        button1.imageView?.contentMode = .scaleAspectFit
        button1.layer.cornerRadius = 20
        button1.setTitle("작성하기", for: .normal)
        button1.setTitleColor(.white, for: .normal)
//        button1.layer.shadowColor = UIColor.gray.cgColor
//        button1.layer.shadowOpacity = 1.0
//        button1.layer.shadowRadius = 6
//        button1.layer.shadowOffset = CGSize(width: 0, height: 5)
        button1.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button1
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .black
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.white
        ]

        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.title = "리뷰쓰기"

        
        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func viewDidLoad(){
        super.viewDidLoad()
      
        view.backgroundColor = .black

        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints{ maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        self.view.addSubview(label1)
        label1.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top)
            maker.height.equalTo(80)
            maker.width.equalTo(view.snp.width)
        }

        
        self.view.addSubview(text1)
        text1.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(55)
            maker.leading.equalTo(view.snp.leading).offset(37)
        }
        

        self.view.addSubview(rateView)
        rateView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }

        self.view.addSubview(text2)
        text2.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(235)
            maker.leading.equalTo(view.snp.leading).offset(37)
        }

        self.view.addSubview(textfield1)
        textfield1.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(268)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(335)
            maker.height.equalTo(163)
        }
        
        
        self.view.addSubview(button1)
        button1.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(475)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(150)
            maker.height.equalTo(46)
        }
        

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) /// 화면을 누르면 키보드 내려가게 하는 것
    }
    
//    @objc func postButtonTapped() {
//        guard let inputText = textfield1.text else {
//            return
//        }
//        print(inputText)
//        print(selectedStarCount)
//
//        let review = Review(score: selectedStarCount, content: inputText)
//        // ReviewService의 인스턴스를 생성
//        let reviewWriteService = ReviewWriteService()
//
//        // 리뷰 작성 통신
//        guard let cafeId = cafeId else {
//            // cafeId가 nil일 경우에 대한 처리 로직
//            print("cafeId가 nil입니다.")
//            return
//        }
//
//        if let userId = UserDefaults.standard.string(forKey: "userId") {
//            reviewWriteService.postReview(userId: userId, cafeId: cafeId, review: review) { result in
//                switch result {
//                case .success(let reviewResponse):
//                    print("리뷰 ID: \(reviewResponse.data.nickname)")
//                case .failure(let error):
//                    print("에러 메시지: \(error.localizedDescription)")
//                    //print(ReviewResponse.)
//                }
//            }
//        } else {
//            print("userId 값이 없음")
//        }
//    }

    @objc func postButtonTapped() {
        guard let inputText = textfield1.text else {
            return
        }
        
        if selectedStarCount == 0 {
            // '별점을 남겨주세요' 팝업 표시
            let alert = UIAlertController(title: "알림", message: "별점을 남겨주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        print(inputText)
        print(selectedStarCount)

        let review = Review(score: selectedStarCount, content: inputText)
        // ReviewService의 인스턴스를 생성
        let reviewWriteService = ReviewWriteService()

        // 리뷰 작성 통신
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil입니다.")
            return
        }

        if let userId = UserDefaults.standard.string(forKey: "userId") {
            reviewWriteService.postReview(userId: userId, cafeId: cafeId, review: review) { result in
                switch result {
                case .success(let reviewResponse):
                    print("리뷰 ID: \(reviewResponse.data.nickname)")
                    // 작성 완료 팝업 표시
                    let alert = UIAlertController(title: "알림", message: "작성이 완료되었습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                        // 팝업을 닫은 후 이전 페이지로 돌아가기
                        self.navigationController?.popViewController(animated: true)
                        if let previousViewController = self.navigationController?.viewControllers.last as? CafeDetailView {
                            previousViewController.viewWillAppear(true)
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                case .failure(let error):
                    print("에러 메시지: \(error.localizedDescription)")
                }
            }
        } else {
            print("userId 값이 없음")
        }
        
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension WriteReviewView: RateViewDelegate{
    // RateViewDelegate 메서드 구현
    func didRate(_ rateView: RateView, withNumberOfStars stars: Int) {
        print("별점: \(stars)개")
        selectedStarCount = stars
    }
}
