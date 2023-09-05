import UIKit
import SnapKit
import Foundation
import Kingfisher

class CafeDetailView: UIViewController,UIGestureRecognizerDelegate {
    
    var collectionView1HeightConstant: CGFloat = 100
    var collectionView2HeightConstant: CGFloat = 100
    
    var cafeMenu: [DetailCafeMenu]?
    var cafeReview: [DetailCafeReview]?
    
    
    var cafeId: String?
    var cafeName: String?
    var cellCount: Int = 0
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        return view
    }()
    
    private let nestedStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = -30
        return view
    }()
    
    private let cafeImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let headerViewSegmentControl = UISegmentedControl()
    private let stickyHeaderViewSegmentControl = UISegmentedControl()
    
    private let cafeView = UIView()
    
    private let cafeNameLabel = UILabel()
    private let cafeLocation = UILabel()
    private let cafeLocationCheck =  UIButton()
    private let dottedLine = CAShapeLayer()
    private let path = CGMutablePath()
    
    
    private let reviewWriteButton =  UIButton()
    
    var isHeartSelected = false
    let heartButton = UIButton()
    let heartFillImage = UIImage(systemName: "heart.fill",
                                 withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    
    let heartEmptyImage = UIImage(systemName: "heart",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    
    private let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 348, height: 115) // 각 셀의 크기를 설정합니다.
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 13 // 셀 행 사이의 최소 간격을 설정합니다.
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // 셀 등록
        collectionView.backgroundColor = UIColor.white // 배경색을 설정

        return collectionView
    }()
    
    private let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 348, height: 115) // 각 셀의 크기를 설정합니다.
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 13 // 셀 행 사이의 최소 간격을 설정합니다.
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // 셀 등록
        collectionView.backgroundColor = UIColor.white // 배경색을 설정

        return collectionView
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .black
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // 여기서 글자 색을 설정
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 여기서 글자 색을 설정

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false

        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            getDetailCafeToken()
            print("Token")
        } else {
            getDetailCafe()
            print("notToken")
        }
        getDetailCafeMenu()
        getDetailCafeReview()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView1.register(CafeDetailViewMenuCell.self, forCellWithReuseIdentifier: "CafeDetailViewMenuCell")
        
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.register(CafeDetailViewReviewCell.self, forCellWithReuseIdentifier: "CafeDetailViewReviewCell")
        collectionView2.isScrollEnabled = false

        // UIScrollView 설정
        scrollView.delegate = self
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.bounces = false // 스크롤 여백 없애기, 대신 스크롤의 튕김이 없어져 스크롤이 부드럽지 못함
        scrollView.decelerationRate = UIScrollView.DecelerationRate.fast
//        scrollView.panGestureRecognizer.require(toFail: collectionView2.panGestureRecognizer)

        cafeView.backgroundColor = .white
        cafeView.layer.cornerRadius = 30
        cafeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
        cafeNameLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        cafeNameLabel.text = "카페네임"
        cafeNameLabel.textColor = .black
        cafeNameLabel.textAlignment = .left
        cafeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cafeLocation.font = UIFont.systemFont(ofSize: 15)
        cafeLocation.text = "카페위치"
        cafeLocation.textColor = .black
        cafeLocation.textAlignment = .left
        cafeLocation.translatesAutoresizingMaskIntoConstraints = false
        
        cafeLocationCheck.setTitle("매장위치 확인>", for: .normal)
        cafeLocationCheck.setTitleColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), for: .normal)
        cafeLocationCheck.backgroundColor = .clear
        cafeLocationCheck.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        dottedLine.strokeColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
        dottedLine.lineWidth = 2
        dottedLine.lineDashPattern = [6, 4] // [실선길이, 공백길이]
        path.addLines(between: [CGPoint(x: 20, y: 100), CGPoint(x: 370, y: 100)]) // 점선 좌표 지정
        dottedLine.path = path
        
        
        //edit button
        reviewWriteButton.translatesAutoresizingMaskIntoConstraints = false
        reviewWriteButton.clipsToBounds = true
        reviewWriteButton.backgroundColor = .black
        reviewWriteButton.layer.cornerRadius = 30
        reviewWriteButton.setImage(UIImage(named: "pencil"), for: .normal)
        reviewWriteButton.addTarget(self, action: #selector(reviewWriteButtonClicked), for: .touchUpInside)
        
        setSegmentControl()
        setHeartButton()
        
        view.addSubview(scrollView)
        view.addSubview(stickyHeaderViewSegmentControl)
        stickyHeaderViewSegmentControl.isHidden = true

        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(nestedStackView)
        nestedStackView.addArrangedSubview(cafeImage)
        nestedStackView.addArrangedSubview(cafeView)
        cafeView.addSubview(cafeNameLabel)
        cafeView.addSubview(cafeLocation)
        cafeView.addSubview(cafeLocationCheck)
        cafeView.addSubview(heartButton)
        cafeView.layer.addSublayer(dottedLine) // 점선을 추가한 CAShapeLayer를 yourView의 서브레이어로 추가합니다.
        
        stackView.addArrangedSubview(headerViewSegmentControl)
        
        stackView.addArrangedSubview(collectionView1)
        stackView.addArrangedSubview(collectionView2)

        view.addSubview(reviewWriteButton)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            //$0.top.equalTo(view.snp.top)
            $0.left.bottom.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide)
            $0.left.equalTo(scrollView.frameLayoutGuide)
            $0.right.equalTo(scrollView.frameLayoutGuide)
            $0.bottom.equalTo(scrollView.contentLayoutGuide)
        }
        
        stackView.backgroundColor = .white
        
        nestedStackView.snp.makeConstraints{
            $0.top.equalTo(scrollView.snp.top)
        }
        cafeImage.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.top)
            $0.height.equalTo(250)
        }
        
        
        cafeView.snp.makeConstraints {
            $0.top.equalTo(cafeImage.snp.bottom)
            $0.height.equalTo(110)
        }
        
        stickyHeaderViewSegmentControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            //$0.top.equalTo(view.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        headerViewSegmentControl.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        cafeNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(cafeView.snp.leading).offset(30)
            make.top.equalTo(cafeView.snp.top).offset(30)
        }
        
        cafeLocation.snp.makeConstraints { make in
            make.leading.equalTo(cafeView.snp.leading).offset(30)
            make.top.equalTo(cafeNameLabel.snp.bottom).offset(8)
        }
        
        cafeLocationCheck.snp.makeConstraints { make in
            make.leading.equalTo(cafeNameLabel.snp.trailing).offset(15)
            make.top.equalTo(cafeView.snp.top).offset(33)
        }
        
        heartButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(325)
            make.top.equalTo(cafeView.snp.top).offset(35)
        }
        
        
        reviewWriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-18)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(310)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        // 초기에는 첫 번째 세그먼트가 선택되도록 설정
        stickyHeaderViewSegmentControl.isHidden = true
        
        updateTableViewVisibility()
    }
    
    private func setHeartButton() {
        // 버튼 설정
        heartButton.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
        heartButton.setImage(heartEmptyImage, for: .normal)
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonTapped() {
        isHeartSelected = !isHeartSelected
        if isHeartSelected {
            heartButton.setImage(heartFillImage, for: .normal)
            registerFavoriteCafe()
            
        } else {
            heartButton.setImage(heartEmptyImage, for: .normal)
            deleteFavoriteCafe()
        }
    }
    
    private func registerFavoriteCafe(){
        let registerFavoriteDetailCafeService = RegisterFavoriteDetailCafeService()

        guard let cafeId = cafeId else {
            print("cafeId nil")
            return
        }

        if let userId = UserDefaults.standard.string(forKey: "userId")  {
            registerFavoriteDetailCafeService.postFavoriteDetailCafe(userId: userId, cafeId: cafeId) { result in
                switch result {
                case .success(let registerFavoriteDetailCafeResponse):
                    print((registerFavoriteDetailCafeResponse.data))
                case .failure(let error):

                    print("에러 메시지: \(error.localizedDescription)")
                }
            }
        } else {
            let alertController = UIAlertController(title: "로그인 후 이용가능합니다.", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // OK 버튼을 클릭하면 실행될 코드
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            heartButton.setImage(heartEmptyImage, for: .normal)
        }
    }
    
    private func deleteFavoriteCafe(){
        let deleteFavoriteDetailCafeService = DeleteFavoriteDetailCafeService()
        
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId nil")
            return
        }
        
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("userId nil")
            return
        }

        if let userId = UserDefaults.standard.string(forKey: "userId") {
            deleteFavoriteDetailCafeService.deleteFavoriteDetailCafe(userId: userId, cafeId: cafeId) { result in
                switch result {
                case .success(let deleteFavoriteDetailCafeResponse):
                    print((deleteFavoriteDetailCafeResponse.data))
                case .failure(let error):
                    print("에러 메시지: \(error.localizedDescription)")
                }
            }
        } else {
            print("로그인 후 이용가능합니다.")
        }
    }
    
    @objc private func segmentControlDidChangeValue(_ segmentControl: UISegmentedControl) {
        let selectedSegmentIndex = segmentControl.selectedSegmentIndex
        headerViewSegmentControl.selectedSegmentIndex = selectedSegmentIndex
        stickyHeaderViewSegmentControl.selectedSegmentIndex = selectedSegmentIndex
        
        updateTableViewVisibility()
    }
    
    private func updateTableViewVisibility() {
        
        if headerViewSegmentControl.selectedSegmentIndex == 0 {
            collectionView1.isHidden = false
            collectionView2.isHidden = true
            reviewWriteButton.isHidden = true
        } else {
            collectionView1.isHidden = true
            collectionView2.isHidden = false
            reviewWriteButton.isHidden = false
        }
    }
    
    func setSegmentControl(){
        // 세그먼트 컨트롤 설정
        headerViewSegmentControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        headerViewSegmentControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        headerViewSegmentControl.selectedSegmentIndex = 0
        
        headerViewSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        headerViewSegmentControl.backgroundColor = .white
        headerViewSegmentControl.tintColor = .red
        
        
        stickyHeaderViewSegmentControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        stickyHeaderViewSegmentControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        stickyHeaderViewSegmentControl.selectedSegmentIndex = 0
        
        stickyHeaderViewSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        stickyHeaderViewSegmentControl.backgroundColor = .white
        
        headerViewSegmentControl.addTarget(self, action: #selector(segmentControlDidChangeValue(_:)), for: .valueChanged)
        stickyHeaderViewSegmentControl.addTarget(self, action: #selector(segmentControlDidChangeValue(_:)), for: .valueChanged)
        
        
        // Change text color and the font of the NOT selected (normal) segment
        headerViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        
        // Change text color and the font of the selected segment
        headerViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
        
        
        // Change text color and the font of the NOT selected (normal) segment
        stickyHeaderViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        
        // Change text color and the font of the selected segment
        stickyHeaderViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
        
        removeBackgroundAndDivider()
        
    }
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        headerViewSegmentControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        headerViewSegmentControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        headerViewSegmentControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        headerViewSegmentControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        stickyHeaderViewSegmentControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        stickyHeaderViewSegmentControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        stickyHeaderViewSegmentControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        stickyHeaderViewSegmentControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
    }
    

    func getDetailCafe() {
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil입니다.")
            return
        }

        let detailcafeservice = DetailCafeByCafeIdService() // DetailCafeService 인스턴스 생성
        detailcafeservice.getDetailCafeBycafeID(cafeID: cafeId) { result in
            switch result {
            case .success(let cafe):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                //print(cafe) // 받아온 데이터 사용 예시
                //print(cafe.cafeImages.count)
                if let imageURL = cafe.cafeImages.first, let url = URL(string: imageURL) {
//                    URLSession.shared.dataTask(with: url) { data, _, error in
//                        if let error = error {
//                            print("Failed to download image:", error)
//                            return
//                        }
//                        if let data = data, let downloadedImage = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                self.cafeImage.image = downloadedImage
//                            }
//                        }
//                    }.resume()
                    self.cafeImage.kf.setImage(with: url)
                }


                DispatchQueue.main.async {
                    self.cafeNameLabel.text = cafe.name
                    self.cafeLocation.text = cafe.address
                }
            case .failure(let error):
                // 데이터를 받아오지 못했을 때의 처리 로직
                print(error.localizedDescription)
                // 에러 메시지 출력 예시
                // 에러 메시지를 보여줄 수 있는 방식으로 처리
                print(error)
            }
        }
    }

    
    func getDetailCafeToken() {
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil")
            return
        }
        
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("userID가 nil")
            return
        }
        
        let detailcafeservice = DetailCafeByCafeIdService() // DetailCafeService 인스턴스 생성
        detailcafeservice.getDetailCafeBycafeIDToken(cafeID: cafeId, userID: userId) { result in
            switch result {
            case .success(let cafe):
               // print(cafe)
                //print(cafe.cafeImages.count)
                if let imageURL = cafe.cafeImages.first, let url = URL(string: imageURL) {
//                    URLSession.shared.dataTask(with: url) { data, _, error in
//                        if let error = error {
//                            print("Failed to download image:", error)
//                            return
//                        }
//                        if let data = data, let downloadedImage = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                self.cafeImage.image = downloadedImage
//                            }
//                        }
//                    }.resume()
                    self.cafeImage.kf.setImage(with: url)
                }
                DispatchQueue.main.async {
                    self.cafeNameLabel.text = cafe.name // 받아온 데이터의 이름을 라벨에 설정
                    self.cafeLocation.text = cafe.address
                }
                
                if cafe.favoritesStatus == "ACTIVE" {
                    self.heartButton.setImage(self.heartFillImage, for: .normal)
                    self.isHeartSelected = true
                } else {
                    self.heartButton.setImage(self.heartEmptyImage, for: .normal)
                    self.isHeartSelected = false
                }
            case .failure(let error):
                // 데이터를 받아오지 못했을 때의 처리 로직
                print(error.localizedDescription)
                // 에러 메시지 출력 예시
                // 에러 메시지를 보여줄 수 있는 방식으로 처리
                print(error)
            }
        }
    }
    
    func getDetailCafeMenu() { //result = getAllCafeInfo 실행해서 얻은 결과
        guard let cafeId = cafeId else {
            print("cafeId nil")
            return
        }
        let detailcafemenuservice = DetailCafeMenuService()
        detailcafemenuservice.getDetailCafeMenuBycafeID(cafeID: cafeId) { [self] result in
            switch result {
            case .success(let response):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                self.cafeMenu = response
                //print(response)

                collectionView1.reloadData() // 컬렉션 뷰 리로드

                let numberOfRowsInCollectionView1 = response.count
                collectionView1HeightConstant = CGFloat(numberOfRowsInCollectionView1) * (115+13) // 115 셀 높이, 13 셀 간격
                collectionView1.snp.makeConstraints {
                    $0.height.equalTo(collectionView1HeightConstant).priority(.low)
                }
                
                print(cellCount)
                
            case .failure(let error):
                // 데이터를 받아오지 못했을 때의 처리 로직
                print(error.localizedDescription)
                // 에러 메시지 출력 예시
                // 에러 메시지를 보여줄 수 있는 방식으로 처리
                print(error)
            }
        }
    
    }
    
    func getDetailCafeReview() { //result = getAllCafeInfo 실행해서 얻은 결과
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil입니다.")
            return
        }
        
        let cafeDetailViewReviewCell = CafeDetailViewReviewCell()
        
        let detailcafereviewservice = DetailCafeReviewService()
        detailcafereviewservice.getDetailCafeReviewBycafeID(cafeID: cafeId, nums: 50) { [self] result in
            switch result {
            case .success(let response):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                self.cafeReview = response.reviewResponses
                //print(self.cafeReview)
                
                let numberOfRowsInCollectionView2 = cafeReview!.count
                collectionView2HeightConstant = CGFloat(numberOfRowsInCollectionView2 ) * (115+13) // 115 셀 높이, 13 셀 간격
                collectionView2.snp.makeConstraints {
                    $0.height.equalTo(collectionView2HeightConstant).priority(.low)
                }
                                
                collectionView2.reloadData() // 컬렉션 뷰 리로드

            case .failure(let error):
                print("review error : \n" + error.localizedDescription)
                // 에러 메시지 출력
                print(error)
            }
        }
    }
    
    func updateCellHeightForNumberOfLines(_ numberOfLines: Int) {
        if let layout = collectionView2.collectionViewLayout as? UICollectionViewFlowLayout {
            if numberOfLines == 1 {
                print("1!!!!!")
                layout.itemSize = CGSize(width: 348, height: 115)
            } else if numberOfLines == 2 {
                print("2!!!!!")
                layout.itemSize = CGSize(width: 348, height: 130)
            } else if numberOfLines == 3 {
                print("3!!!!!")
                layout.itemSize = CGSize(width: 348, height: 145)
            }
            collectionView2.collectionViewLayout.invalidateLayout()
        }
    }
    
    @objc func reviewWriteButtonClicked() {
        let nextVC = WriteReviewView()
        nextVC.cafeId = self.cafeId
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            let alertController = UIAlertController(title: "로그인 후 이용가능합니다.", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // OK 버튼을 클릭하면 실행될 코드
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}

extension CafeDetailView: UICollectionViewDataSource, UICollectionViewDelegate, CafeDetailViewReviewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            if let count = cafeMenu?.count {
               // print("collectionview1 count: ", count)
                //print(type(of: count))
                return count
            }
            return 1
        } else if collectionView == collectionView2 {
            //print("collection2")
            if let count = cafeReview?.count {
                //print("collectionview2 count :", count)
                return count
            }
            return 1
        }
            return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CafeDetailViewMenuCell", for: indexPath) as! CafeDetailViewMenuCell
            if let menu = cafeMenu?[indexPath.row] {
                cell.configure(imageURL: menu.imageUrl, menu: menu.name, price: "\(menu.price)", menuDescription: menu.description)
            }else {
                cell.configure(imageURL: nil, menu: "아메리카노", price: "3500", menuDescription: "맛있다!")
            }
            
            return cell
            
        }else if collectionView == collectionView2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CafeDetailViewReviewCell", for: indexPath) as! CafeDetailViewReviewCell
            
            cell.delegate = self
            
            if let review = cafeReview?[indexPath.row]{
                cell.configure(userId: review.userId, nickname: review.nickname, review: review.content, score: review.score)
            }else {
                cell.configure(userId:"1", nickname: "카자잇", review: "리뷰입니다", score: 5)

            }
            return cell
            
        }else {
            return UICollectionViewCell()
        }

    }
    
    func deleteButtonTapped(in cell: CafeDetailViewReviewCell) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)

        if cell.deleteButton.title(for: .normal) == "신고" {
            alertController.title = "서비스를 준비 중입니다"
            alertController.message = ""
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            }
            alertController.addAction(okAction)
            
        } else if cell.deleteButton.title(for: .normal) == "삭제" {
            alertController.title = "삭제하시겠습니까"
            alertController.message = ""
            
            let okAction = UIAlertAction(title: "네", style: .default) { (action) in
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

        }

    
        // 알림창을 화면에 표시
        self.present(alertController, animated: true, completion: nil)
    }
    
    func editButtonTapped(in cell: CafeDetailViewReviewCell) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)

        alertController.title = "수정하시겠습니까"
        alertController.message = ""
        
        let okAction = UIAlertAction(title: "네", style: .default) { (action) in
            let nextVC = WriteReviewView()
            nextVC.cafeId = self.cafeId
            
            self.navigationController?.pushViewController(nextVC, animated: true)

        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

    
        // 알림창을 화면에 표시
        self.present(alertController, animated: true, completion: nil)
    }
    
}


extension CafeDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y: 손가락을 위로 올리면 + 값, 손가락을 아래로 내리면 - 값
        //print(scrollView.contentOffset.y, headerViewSegmentControl.frame.minY)
        
        // frame.minY를 통해 sticky 타이밍 계산
        let shouldShowSticky = scrollView.contentOffset.y >= headerViewSegmentControl.frame.minY
        stickyHeaderViewSegmentControl.isHidden = !shouldShowSticky
        //print(!shouldShowSticky)
        
        if shouldShowSticky {
            self.navigationController?.navigationBar.topItem?.title = cafeNameLabel.text
            let attributes: [NSAttributedString.Key: Any] = [
                   .foregroundColor: UIColor.white, // 흰색으로 변경
                   .font: UIFont.boldSystemFont(ofSize: 18)
               ]
            self.navigationController?.navigationBar.titleTextAttributes = attributes
    
        } else {
            navigationController?.navigationBar.topItem?.title = ""
        }

        if headerViewSegmentControl.frame.minY == 0.0 {
            stickyHeaderViewSegmentControl.isHidden = true
        }
    }
}
