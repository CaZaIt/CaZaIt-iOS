//
//  ItemView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/04/02.
//

import UIKit
import SnapKit

class MainView: UIViewController {

    let mainTopSearchView = MainTopSearchView()
    private var allCafeData: AllCafeResponse? //통신한 데이터를 저장하기 위한 변수입니다.
    
    private let whiteView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private let blackView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        
        return view
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false //수직 스크롤 인디게이터를 보이지 않게 함
        tableView.backgroundColor = .white
        tableView.sectionHeaderTopPadding = 0 //상단 패딩을 0으로 지정한다.
        tableView.separatorStyle = .none //tableView의 구분선을 없앤다.
        tableView.contentInset = UIEdgeInsets(top: 99, left: 0, bottom: 0, right: 0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewLovedCell.self, forCellReuseIdentifier: "MainTableViewLovedCell")
        mainTableView.register(MainTableViewCafeCell.self, forCellReuseIdentifier: "MainTableViewCafeCell")
        
        // mainTopSearchView의 버튼 액션을 처리하는 메서드를 설정합니다.
        //상단 검색버튼 클릭시 검색화면으로 이동합니다.
        mainTopSearchView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        setupMainTableView()
        getAllCafeInfoData()
    }
    
    func getAllCafeInfoData() {
        AllCafeService.shared.getAllCafeInfo(longitude : "127.07154626749393", latitude : "37.54751410359858", sort : "distance", limit : "0") { response in

            switch response {

            case .success(let data):
                guard let listData = data as? AllCafeResponse else {return}
                self.allCafeData = listData //통신한 데이터를 변수에 저장하고
                self.mainTableView.reloadData() //통신을 적용하기 위해 테이블 뷰를 리로드합니다.
                
                // 실패할 경우에 분기처리는 아래와 같이 합니다.
            case .requestErr :
                print("requestErr")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serveErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    @objc func searchButtonTapped() {
        let searchViewController = SearchView()
        navigationController?.pushViewController(searchViewController, animated: false)
        //버튼 클릭시 이동하는 화면에서 searchBar가 클릭된 상태로 시작합니다.
        searchViewController.searchBar.becomeFirstResponder()
    }
    
    func setupMainTableView() {
        view.addSubview(whiteView)
        
        whiteView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(blackView)
        
        blackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        whiteView.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(whiteView.snp.bottom)
        }
        
        whiteView.addSubview(mainTopSearchView)
        
        mainTopSearchView.snp.makeConstraints { make in
            make.top.equalTo(whiteView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(99)
        }
    
        
    }
    //상단의 시계가 흰색으로 표시되게 하기 위해서 추가하는 코드입니다.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 밝은 배경색일 경우에는 .darkContent
    }
    
    //다른 곳 클릭시 키보드 내려가게 만들기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.mainTableView.endEditing(true)
    }
    
    var previousScrollViewYOffset: CGFloat = 0.0
    
    //스크롤 시 뷰의 이동을 나타내는 코드입니다.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // scrollViewYOffset: 스크롤 뷰의 현재 스크롤 위치를 나타내는 변수입니다.
        let scrollViewYOffset = scrollView.contentOffset.y //즉, 스크롤이 된 정도를 나타냅니다. 웹툰보는 방향으로 드래그 할 경우 양의 방향으로 증가가 됩니다.
        // contentHeight: 스크롤 뷰의 콘텐츠 높이를 나타내는 변수입니다.
        let contentHeight = scrollView.contentSize.height //즉, tableView의 전체 높이를 나타냅니다.
        // scrollViewFrameHeight: 스크롤 뷰의 프레임 높이를 나타내는 변수입니다.
        let scrollViewFrameHeight = scrollView.frame.size.height// 즉, 우리가 볼수있는 tableView의 높이를 나타냅니다.
        
//        print("scrollViewYOffset : \(scrollViewYOffset)")
//        print("contentHeight : \(contentHeight)")
//        print("scrollViewFrameHeight : \(scrollViewFrameHeight)")
//        print("previousScrollViewYOffset : \(previousScrollViewYOffset)")
        
        //현재의 tableView의 상단 위치와 바로 직전 tableView의 상단 위치를 비교하여 스크롤을 내릴때와 올라갈 때를 감지합니다.
        // 스크롤을 아래로 내리는 경우 (우리가 웹툰보는 방향의 스크롤)
        if scrollViewYOffset > previousScrollViewYOffset {
            
            //현재 스크롤된 값이 -99(상단 검색창의 높이)보다 높을 경우에만 검색창이 위로 이동하도록 합니다.
            //tableView의 상단 패딩의 값이 99로 해놓았기 때문에 초기 값은 -99가 됩니다.
            if scrollViewYOffset > -99.0 {
                //deltaY선언하여 현재의 offset과 이전의 offset값을 비교하여 어느정도 변화했는지 감지합니다.
                let deltaY = scrollViewYOffset - previousScrollViewYOffset
                
                //새로운 검색창의 Y값은 원래 Y값에서 변화된 값을 뺀 값입니다.
                var newMainTopSearchViewY = self.mainTopSearchView.frame.origin.y - deltaY
                
                //검색창의 새로운 Y의 값이 검색창의 높이보다 더 낮아질 경우 검색창이 계속해서 올라가기 때문에 검색창의 높이만큼만 제한합니다.
                if newMainTopSearchViewY < -self.mainTopSearchView.frame.size.height {
                    newMainTopSearchViewY = -self.mainTopSearchView.frame.size.height
                }
                
                //검색창의 y의 값을 수정하여 검색창을 위로 이동시킵니다. newMainTopSearchViewY값은 음의 방향으로 이동합니다.
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainTopSearchView.frame = CGRect(x: 0, y: newMainTopSearchViewY, width: self.view.frame.size.width, height: self.mainTopSearchView.frame.size.height)
                })
            }
        }// 스크롤을 위로 올리는 경우 (우리가 웹툰보는 방향과 반대방향의 스크롤), 또한, tableView의 스크롤 된 정도 + tableView가 보여줄 수 있는 높이가 < 전체 tableView의 높이보다 작을 경우에만 검색창이 다시 등장하게 합니다. (즉, 스크롤을 다 하고도 계속 해서 내리면 빈 공백이 스크롤되고 다시 원위치로 약간 돌아올 경우에 검색창이 다시 약간 내려오는 경우를 방지합니다.)
        else if scrollViewYOffset < previousScrollViewYOffset && scrollViewYOffset + scrollViewFrameHeight < contentHeight{
            
            //deltaY선언하여 현재의 offset과 이전의 offset값을 비교하여 어느정도 변화했는지 감지합니다.
            let deltaY = previousScrollViewYOffset - scrollViewYOffset
            
            //새로운 검색창의 Y값은 원래 Y값에서 변화된 값을 더한 값입니다.
            var newMainTopSearchViewY = self.mainTopSearchView.frame.origin.y + deltaY
            
            //만약 원래 검색창의 frame.origin.y값은 0보다 크게 될 경우 검색창이 계속 내려가게 됨으로 0보다 클 경우 0으로 고정합니다.
            if newMainTopSearchViewY > 0 {
                newMainTopSearchViewY = 0
            }
            //검색창의 y의 값을 수정하여 검색창을 아래로 이동시킵니다. newMainTopSearchViewY값은 음수에서 0으로 이동합니다.
            UIView.animate(withDuration: 0.2, animations: {
                self.mainTopSearchView.frame = CGRect(x: 0, y: newMainTopSearchViewY, width: self.view.frame.size.width, height: self.mainTopSearchView.frame.size.height)
            })
        }
        
        //이전의 yOffset값을 저장함으로써 스크롤 방향을 정할 때 사용합니다.
        previousScrollViewYOffset = scrollViewYOffset
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource{
    
    //mainTableView의 섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //mainTableView의 각 섹션 마다 cell row 숫자의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    //mainTableView의 각 센션 마다 사용할 cell의 종류
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewLovedCell", for: indexPath) as! MainTableViewLovedCell
            cell.navigationController = navigationController
            // 첫 번째 섹션에서 사용할 셀 구성
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCafeCell", for: indexPath) as! MainTableViewCafeCell
            cell.navigationController = navigationController
            cell.configure(with: self.allCafeData) //테이블 뷰 cell에 정보를 전달합니다.
            // 두 번째 섹션에서 사용할 셀 구성
            return cell
        }
    }

    //mainTableViewCell의 높이를 지정한다.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 277
        } else { //section1의 경우 수직방향 collectionView이므로 cell의 갯수에 따라 높이가 다르게 지정된다.
            let cell = MainTableViewCafeCell()
            let cellHeight = cell.calculateCellHeight()
            return cellHeight
        }
    }
    
    
}
