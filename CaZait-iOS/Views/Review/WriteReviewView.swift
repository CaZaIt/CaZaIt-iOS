//
//  WriteReviewView.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/22.
//

import UIKit
import SnapKit


class WriteReviewView: UIViewController, UITextViewDelegate{
    var cafeId: String?
    var reviewId: String?
    var reviewButton: Int = 0
        
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
    
    
    let textView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "공백 포함 최대 50자 이내로 작성해주세요."
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 25
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.textContainerInset = UIEdgeInsets(top: 18, left: 15, bottom: 18, right: 15)
        
        return textView
    }()
    

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
        
        if reviewButton == 1 {
            self.title = "리뷰 쓰기"
        }else {
            self.title = "리뷰 수정하기"
        }

        
        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func viewDidLoad(){
        super.viewDidLoad()
      
        view.backgroundColor = .black

        print(reviewButton)
        
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
        
        textView.delegate = self

        self.view.addSubview(textView)
        textView.snp.makeConstraints { maker in
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

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            // If the text is empty, show the placeholder text
            textView.textColor = UIColor.lightGray
        } else if textView.textColor == UIColor.lightGray && !textView.text.isEmpty {
            // If the text is not empty and the textColor is still lightGray, change it to black
            textView.textColor = UIColor.black
            textView.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 현재 텍스트 뷰의 텍스트와 변경되는 텍스트를 합쳐서 길이를 계산
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // 길이가 50자 이하인지 확인
        return newText.count <= 50
    }

    @objc func postButtonTapped() {
        guard let inputText = textView.text else {
            return
        }
        
        if selectedStarCount == 0 {
            let alert = UIAlertController(title: "", message: "별점을 남겨주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        print(inputText)
        print(selectedStarCount)
        
        let review = Review(score: selectedStarCount, content: inputText)
        
        if reviewButton == 1 {
            writeReview(review: review)
        }else {
            editReview(review: review)
        }
    }
    
    func writeReview(review: Review) {
        let reviewWriteService = ReviewWriteService()

        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil")
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

    func editReview(review: Review) {
        let reviewEditService = ReviewEditService()

        guard let reviewId = reviewId else {
            print("reviewId가 nil")
            return
        }

        if let userId = UserDefaults.standard.string(forKey: "userId") {
            reviewEditService.editReview(reviewId: reviewId, review: review) { result in
                switch result {
                case .success(let reviewEditResponse):
                    print("리뷰 ID: \(reviewEditResponse.data.reviewId)")
                    let alert = UIAlertController(title: "알림", message: "수정이 완료되었습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
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
            print("reviewId 값이 없음")
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
