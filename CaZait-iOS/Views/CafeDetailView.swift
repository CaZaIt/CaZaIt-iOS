import UIKit

class CafeDetailView: UIViewController {
    private let scrollView = UIScrollView()
    private let cafeImage = UIImageView()
    private let headerView = UIView()
    private let segmentedControl = UISegmentedControl()
    private let tableView1 = UITableView()
    private let tableView2 = UITableView()
    private let reviewWriteButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false
            // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
            self.navigationController?.navigationBar.barStyle = .black
            //self.navigationController?.navigationBar.isTranslucent = true

        }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.isNavigationBarHidden = true
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
           
        // 카페 이미지 설정
        cafeImage.image = UIImage(named: "big_cafe") // 피럴랙스 이미지 설정
        cafeImage.contentMode = .scaleAspectFill
        cafeImage.clipsToBounds = true
        cafeImage.translatesAutoresizingMaskIntoConstraints = false

        // UIScrollView 설정
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // 콘텐츠 높이 설정
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 400)

     
        // 헤더뷰 설정
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 카페 이름 라벨
        let cafeName = UILabel()
        cafeName.text = "롬곡"
        cafeName.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        cafeName.textAlignment = .left
        cafeName.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(cafeName)

        // 카페 위치 라벨
        let cafeLocation = UILabel()
        cafeLocation.text = "서울특별시 광진구 광나루로 375-1 2층(군자동)"
        cafeLocation.font = UIFont.systemFont(ofSize: 15)
        cafeLocation.textAlignment = .left
        cafeLocation.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(cafeLocation)
        
        // 리뷰쓰기 버튼
        let reviewWriteButton =  UIButton()
        reviewWriteButton.translatesAutoresizingMaskIntoConstraints = false
        reviewWriteButton.backgroundColor = .black
        reviewWriteButton.layer.cornerRadius = 20
        reviewWriteButton.setTitle("리뷰쓰기", for: .normal)
        reviewWriteButton.addTarget(self, action: #selector(reviewWriteButtonClicked), for: .touchUpInside)

        // 세그먼트 컨트롤 설정
        segmentedControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        
        // Change text color and the font of the NOT selected (normal) segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)

        // Change text color and the font of the selected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
   
        // 테이블 뷰 설정
        tableView1.backgroundColor = .white
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        
        tableView1.dataSource = self
        tableView1.delegate = self

        tableView2.backgroundColor = .white
        tableView2.translatesAutoresizingMaskIntoConstraints = false

        tableView2.dataSource = self
        tableView2.delegate = self
        
        // 테이블뷰 cell
        tableView1.register(CafeDetailViewMenuCell.self, forCellReuseIdentifier: "CafeDetailViewMenuCell")
        tableView2.register(CafeDetailViewReviewCell.self, forCellReuseIdentifier: "CafeDetailViewReviewCell")

     
        view.addSubview(cafeImage)
        view.addSubview(scrollView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(tableView1)
        scrollView.addSubview(tableView2)
        tableView2.addSubview(reviewWriteButton)

        
        // 제약 조건
        cafeImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(250)
        }
                
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(cafeImage.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
           
        headerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.height.equalTo(100)
        }

        cafeName.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top).offset(16)
            make.leading.equalTo(headerView.snp.leading).offset(25)
        }
        
        
        cafeLocation.snp.makeConstraints { make in
            make.top.equalTo(cafeName.snp.bottom).offset(8)
            make.leading.equalTo(headerView.snp.leading).offset(25)
        }
        
 
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        
        tableView1.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
        }

        
        tableView2.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
        }
                
        reviewWriteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(600)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(45)
            make.width.equalTo(300)
        }

        // 초기에는 첫 번째 세그먼트가 선택되도록 설정
        updateTableViewVisibility()
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateTableViewVisibility()
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        // 이미지의 위치를 스크롤 속도보다 더 느리게 이동하도록 설정


    }
    
    
    @objc func reviewWriteButtonClicked() {
        let nextVC = WriteReviewView()
        navigationController?.pushViewController(nextVC, animated: true)
        //present(nextVC, animated: true, completion: nil)
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
