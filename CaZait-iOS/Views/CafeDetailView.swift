import UIKit
import SnapKit
import Foundation

class CafeDetailView: UIViewController,UIGestureRecognizerDelegate {
    
    var collectionView1HeightConstant: CGFloat = 100
    var collectionView2HeightConstant: CGFloat = 400
    
    var cafeMenu: [DetailCafeMenu]?
    var cafeReview: [DetailCafeReview]?
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
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
        view.image = UIImage(named: "big_cafe")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let headerViewSegmentControl = UISegmentedControl()
    private let stickyHeaderViewSegmentControl = UISegmentedControl()
    
    private let cafeView = UIView()
    
    private let cafeName = UILabel()
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
    
    var cafeId : Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .black
        
        // 뒤로가기 버튼 추가
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        
        getDetailCafe()
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
        //print("!!!!!!!!!!!!!", cafeId)
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView1.register(CafeDetailViewMenuCell.self, forCellWithReuseIdentifier: "CafeDetailViewMenuCell")
        
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.register(CafeDetailViewReviewCell.self, forCellWithReuseIdentifier: "CafeDetailViewReviewCell")
        // UIScrollView 설정
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //손가락 옆으로 미는 제스쳐 작동
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        cafeView.backgroundColor = .white
        cafeView.layer.cornerRadius = 30
        cafeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
        cafeName.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        cafeName.text = "카페네임"
        cafeName.textColor = .black
        cafeName.textAlignment = .left
        cafeName.translatesAutoresizingMaskIntoConstraints = false
        
        cafeLocation.font = UIFont.systemFont(ofSize: 15)
        cafeLocation.text = "카페위치"
        cafeName.textColor = .black
        cafeLocation.textAlignment = .left
        cafeLocation.translatesAutoresizingMaskIntoConstraints = false
        
        // 버튼 설정
        cafeLocationCheck.setTitle("매장위치 확인>", for: .normal)
        cafeLocationCheck.setTitleColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), for: .normal)
        cafeLocationCheck.backgroundColor = .clear
        cafeLocationCheck.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        dottedLine.strokeColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
        dottedLine.lineWidth = 2
        dottedLine.lineDashPattern = [6, 4] // [실선길이, 공백길이]를 반복하면서 그려 점선을 만듭니다.
        path.addLines(between: [CGPoint(x: 20, y: 100), CGPoint(x: 370, y: 100)]) // 점선을 그리고 싶은 좌표를 지정합니다.
        
        dottedLine.path = path // CAShapeLayer에 점선을 추가합니다.
        
        
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
        nestedStackView.addArrangedSubview(cafeImage)
        nestedStackView.addArrangedSubview(cafeView)
        stackView.addArrangedSubview(nestedStackView)
        cafeView.addSubview(cafeName)
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
            $0.left.bottom.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        cafeImage.snp.makeConstraints {
            $0.height.equalTo(250)
        }
        
        
        cafeView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
        
        stickyHeaderViewSegmentControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        headerViewSegmentControl.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        cafeName.snp.makeConstraints { make in
            make.leading.equalTo(cafeView.snp.leading).offset(30)
            make.top.equalTo(cafeView.snp.top).offset(30)
        }
        
        cafeLocation.snp.makeConstraints { make in
            make.leading.equalTo(cafeView.snp.leading).offset(30)
            make.top.equalTo(cafeName.snp.bottom).offset(8)
        }
        
        cafeLocationCheck.snp.makeConstraints { make in
            make.leading.equalTo(cafeName.snp.trailing).offset(15)
            make.top.equalTo(cafeView.snp.top).offset(33)
        }
        
        heartButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(325)
            make.top.equalTo(cafeView.snp.top).offset(35)
        }
        
        
        reviewWriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600).isActive = true
        reviewWriteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 310).isActive = true
        reviewWriteButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        reviewWriteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
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
                    print(cafeId, "번 카페 관심 등록")
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
                    print(cafeId, "번 카페 관심 해제")
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
        print("cafeID: ",cafeId)
        let detailcafeservice = DetailCafeService() // DetailCafeService 인스턴스 생성
        detailcafeservice.getDetailCafeBycafeID(cafeID: cafeId) { result in
            switch result {
            case .success(let cafe):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                //print(cafe) // 받아온 데이터 사용 예시
                // UI 업데이트 또는 필요한 작업 수행
                DispatchQueue.main.async {
                    self.cafeName.text = cafe.name // 받아온 데이터의 이름을 라벨에 설정
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
    
    func getDetailCafeMenu() { //result = getAllCafeInfo 실행해서 얻은 결과
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil입니다.")
            return
        }
        let detailcafemenuservice = DetailCafeMenuService()
        detailcafemenuservice.getDetailCafeMenuBycafeID(cafeID: cafeId) { [self] result in
            switch result {
            case .success(let response):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                self.cafeMenu = response
                //print(response)
//                print(self.cafeMenu)
//
//                for menu in response {
//                    let name = menu.name
//                    let description = menu.description
//                    let price = menu.price
//
//                    print("name: \(name)")
//                    print("description: \(description)")
//                    print("price: \(price)")
//                }
                collectionView1.reloadData() // 컬렉션 뷰 리로드

                // print("cafe menu: ", response.count)
                let numberOfRowsInCollectionView1 = response.count
                collectionView1HeightConstant = CGFloat(numberOfRowsInCollectionView1 ) * (115+13) // 115 셀 높이, 13 셀 간격
                collectionView1.snp.makeConstraints {
                    $0.height.equalTo(collectionView1HeightConstant).priority(.low)
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
    
    func getDetailCafeReview() { //result = getAllCafeInfo 실행해서 얻은 결과
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil입니다.")
            return
        }
        let detailcafereviewservice = DetailCafeReviewService()
        detailcafereviewservice.getDetailCafeReviewBycafeID(cafeID: cafeId) { [self] result in
            switch result {
            case .success(let response):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                self.cafeReview = response.reviewResponses
                //print(response)
                //print(self.cafeReview)

                collectionView2.reloadData() // 컬렉션 뷰 리로드
                
                let numberOfRowsInCollectionView2 = cafeReview!.count
                collectionView2HeightConstant = CGFloat(numberOfRowsInCollectionView2 ) * (115+13) // 115 셀 높이, 13 셀 간격
                collectionView2.snp.makeConstraints {
                    $0.height.equalTo(collectionView2HeightConstant).priority(.low)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                // 에러 메시지 출력
                print(error)
            }
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

extension CafeDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
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
            //print("cell")
            //print("row : ", cafeMenu?[indexPath.row])
            //print("cafe menu : " ,cafeMenu)
            if let menu = cafeMenu?[indexPath.row] {
                //print("menu :", menu)
//                print("name: \(menu.name)")
//                print("description: \(menu.description)")
//                print("price: \(menu.price)")
                cell.configure(imageURL: menu.imageUrl, menu: menu.name, price: "\(menu.price)", menuDescription: menu.description)
            }else {
                cell.configure(imageURL: nil, menu: "아메리카노", price: "3500", menuDescription: "맛있다!")
            }

            return cell
        }else if collectionView == collectionView2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CafeDetailViewReviewCell", for: indexPath) as! CafeDetailViewReviewCell
            if let review = cafeReview?[indexPath.row]{
                cell.configure(nickname: review.userId, review: review.content, score: review.score)
            }

            return cell
        }else {
            return UICollectionViewCell()
        }

    }
    
}


extension CafeDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y: 손가락을 위로 올리면 + 값, 손가락을 아래로 내리면 - 값
        //print(scrollView.contentOffset.y, headerViewSegmentControl.frame.minY)
        
        // frame.minY를 통해 sticky 타이밍 계산
        let shouldShowSticky = scrollView.contentOffset.y >= headerViewSegmentControl.frame.minY
        stickyHeaderViewSegmentControl.isHidden = !shouldShowSticky
        
        if headerViewSegmentControl.frame.minY == 0.0 {
            stickyHeaderViewSegmentControl.isHidden = true
        }
    }
}


