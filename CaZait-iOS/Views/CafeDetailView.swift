import UIKit

class CafeDetailView: UIViewController {
    private let scrollView = UIScrollView()
    private let parallaxImageView = UIImageView()
    private let headerView = UIView()
    private let segmentedControl = UISegmentedControl()
    private let tableView1 = UITableView()
    private let tableView2 = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false
            // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
            self.navigationController?.navigationBar.barStyle = .black
            
        }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.isNavigationBarHidden = true
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // UIScrollView 설정
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        // 스크롤뷰의 contentInsetAdjustmentBehavior를 설정합니다.
//        if #available(iOS 11.0, *) {
//            scrollView.contentInsetAdjustmentBehavior = .automatic
//        } else {
//            automaticallyAdjustsScrollViewInsets = true
//        }

        // 헤더뷰 설정
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        
        // 첫 번째 라벨 추가
        let cafeName = UILabel()
        cafeName.text = "롬곡"
        cafeName.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        cafeName.textAlignment = .left
        cafeName.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(cafeName)

        // 두 번째 라벨 추가
        let cafeLocation = UILabel()
        cafeLocation.text = "서울특별시 광진구 광나루로 375-1 2층(군자동)"
        cafeLocation.font = UIFont.systemFont(ofSize: 15)
        cafeLocation.textAlignment = .left
        cafeLocation.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(cafeLocation)

        // 첫 번째 라벨 제약조건 설정
        cafeName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        cafeName.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16).isActive = true

        // 두 번째 라벨 제약조건 설정
        cafeLocation.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        cafeLocation.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: 8).isActive = true


        // 피럴랙스 효과를 가진 이미지 설정
        parallaxImageView.image = UIImage(named: "big_cafe") // 피럴랙스 이미지 설정
        parallaxImageView.contentMode = .scaleAspectFill
        parallaxImageView.clipsToBounds = true
        parallaxImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(parallaxImageView)

        parallaxImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        parallaxImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        parallaxImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        parallaxImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        parallaxImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        headerView.topAnchor.constraint(equalTo: parallaxImageView.bottomAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // 세그먼트 컨트롤 설정
        segmentedControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        //segmentedControl.backgroundColor = .white

        
        // Change text color and the font of the NOT selected (normal) segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)

        // Change text color and the font of the selected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
    

        scrollView.addSubview(segmentedControl)
        segmentedControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16).isActive = true

        // 콘텐츠 높이 설정
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 400)


        // 테이블 뷰 설정
        tableView1.backgroundColor = .white
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tableView1)

        tableView1.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16).isActive = true
        tableView1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView1.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView1.dataSource = self
        tableView1.delegate = self

        tableView2.backgroundColor = .white
        tableView2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tableView2)

        tableView2.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16).isActive = true
        tableView2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView2.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView2.dataSource = self
        tableView2.delegate = self
        
        tableView1.register(CafeDetailViewMenuCell.self, forCellReuseIdentifier: "CafeDetailViewMenuCell")
        tableView2.register(CafeDetailViewReviewCell.self, forCellReuseIdentifier: "CafeDetailViewReviewCell")


        // 초기에는 첫 번째 세그먼트가 선택되도록 설정
        updateTableViewVisibility()
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateTableViewVisibility()
    }


        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            // 이미지의 위치를 스크롤 속도보다 더 느리게 이동하도록 설정
            parallaxImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/2)
        }



    private func updateTableViewVisibility() {
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView1.isHidden = false
            tableView2.isHidden = true
        } else {
            tableView1.isHidden = true
            tableView2.isHidden = false
        }
    }
}

extension CafeDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return 20 // 첫 번째 테이블 뷰에는 10개의 셀을 표시
        } else if tableView == tableView2 {
            return 5 // 두 번째 테이블 뷰에는 5개의 셀을 표시
        } else {
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CafeDetailViewMenuCell", for: indexPath) as! CafeDetailViewMenuCell
            //cell.textLabel?.text = "Row \(indexPath.row + 1)"
            return cell
        } else if tableView == tableView2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CafeDetailViewReviewCell", for: indexPath) as! CafeDetailViewReviewCell
            // Configure the cell with the review data
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 높이 설정
        return 100
    }
    


}

