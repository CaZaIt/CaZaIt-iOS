//
//  SearchView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/16.
//

import Foundation
import UIKit
import SnapKit

class SearchView: UIViewController {
    
    //isTableView는 검색을 한 뒤, 그에 해당하는 카페를 보고 난 뒤, 다시 검색했던 collectionView로 돌아올 경우 키보드가 다시 자동생성되는 것을 방지하기 위해서 만든 변수입니다.
    private var isTableView : Bool = true
    private var searchCafeData : AllCafeResponse?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.searchTextField.backgroundColor = .black
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = UIColor.white
        
        return searchBar
    }()
    
    private let searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false //수직 스크롤 인디게이터를 보이지 않게 함
        tableView.backgroundColor = .yellow
        tableView.sectionHeaderTopPadding = 0 //상단 패딩을 0으로 지정한다.
        
        return tableView
    }()
    
    private let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //스크롤 방향은 수직
        layout.sectionInset = UIEdgeInsets(top: 18, left: 38, bottom: 18, right: 38)//collectionView와 collectionViewCell사이의 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false //수평 스크롤 인디게이터를 보이지 않게 함
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    private let pinkView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
        
        return view
    }()
    
    private let searchedLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "'검색할 내용' 검색결과"
        label.numberOfLines = 1
        
       return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        searchBar.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        setupNavigation()
        setupSearchingView()
        setupSearchedView()
    }
    
    func setupNavigation() {
        // 네비게이션 바에 UISearchBar 추가
        navigationItem.titleView = searchBar
        
        // 네비게이션 색 변경 실패
//        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1) // 원하는 배경색으로 변경
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
//        if let navigationBarAppearance = navigationController?.navigationBar.standardAppearance {
//            navigationBarAppearance.configureWithOpaqueBackground()
//            navigationBarAppearance.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
//            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
//            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
//            navigationController?.navigationBar.compactAppearance = navigationBarAppearance
//        }
        
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    func setupSearchingView() {
        view.addSubview(searchTableView)
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupSearchedView() {
        
        view.addSubview(searchedLabel)
        
        searchedLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.leading.equalTo(view.snp.leading).offset(29)
        }
        
        view.addSubview(searchCollectionView)
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchedLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        //초기에는 무조건 연관검색어가 나와야하므로 검색버튼을 클릭해서 나오는 collectionView는 히든처리합니다.
        searchCollectionView.isHidden = true
        searchedLabel.isHidden = true
    }
    
    func getSearchCafeInfoData(cafeName : String) {
        SearchCafeService.shared.getSearchCafeInfo(cafeName : cafeName, longitude : "127.07154626749393", latitude : "37.54751410359858", sort : "distance", limit : "0") { response in

            switch response {

            case .success(let data):
                guard let listData = data as? AllCafeResponse else {return}
                self.searchCafeData = listData //통신한 데이터를 변수에 저장하고
                self.searchTableView.reloadData() //통신을 적용하기 위해 테이블 뷰를 리로드합니다
                self.searchCollectionView.reloadData() //통신을 적용하기 위해 콜렉션 뷰를 리로드합니다.
                
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //버튼 클릭시 이동하는 화면에서 searchBar가 클릭된 상태로 시작합니다.
        if (isTableView == true) {
            searchBar.becomeFirstResponder()
        }
    }
    
    //mainView에는 네비게이션바가 없기때문에 검색창을 나갈때는 다시 네비게이션바를 없애는 코드를 추가합니다.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
}


extension SearchView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색 텍스트가 변경될 때마다 자동완성을 업데이트합니다.
        
        if (searchText == "") {
            searchCafeData = nil
            searchTableView.reloadData()
        }
        
        //검색텍스트가 변경되었으므로 searchTabletionView를 보여줍니다.
        searchTableView.isHidden = false
        searchCollectionView.isHidden = true
        searchedLabel.isHidden = true
        isTableView = true
        
        getSearchCafeInfoData(cafeName: searchText)
        print("Search keyword: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 버튼을 클릭했을 때의 동작을 처리합니다.
        
        searchedLabel.text = "'\(searchBar.text!)' 검색 결과"
        
        //검색버튼을 클릭했으므로 searchCollectionView를 보여줍니다.
        searchTableView.isHidden = true
        searchCollectionView.isHidden = false
        searchedLabel.isHidden = false
        isTableView = false
        
        searchBar.resignFirstResponder() // 키보드 내리기
    }
    
}

extension SearchView: UITableViewDelegate, UITableViewDataSource{
    
    //mainTableView의 섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //mainTableView의 각 섹션 마다 cell row 숫자의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.searchCafeData?.data[0].count {
            return count
        } else {
            return 0
        }
    }

    //mainTableView의 각 센션 마다 사용할 cell의 종류
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.navigationController = navigationController
        
        //cell 선택시 보여지는 이벤트를 없앱니다.
        cell.selectionStyle = .none
        
        if let cafeInfo = self.searchCafeData?.data[0][indexPath.row]{
            cell.configure(with: cafeInfo)
        }
        
        return cell
    }
    
    // 셀이 선택되었을 때 작업을 수행할 수 있는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchBar.text = self.searchCafeData?.data[0][indexPath.row].name
        searchedLabel.text = "'\(searchBar.text!)' 검색 결과"
        
        //검색버튼을 클릭했으므로 searchCollectionView를 보여줍니다.
        searchTableView.isHidden = true
        searchCollectionView.isHidden = false
        searchedLabel.isHidden = false
        isTableView = false
        
        searchBar.resignFirstResponder() // 키보드 내리기
    }

    //mainTableViewCell의 높이를 지정한다.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
}


extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // collectionView 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = self.searchCafeData?.data[0].count {
            return count
        } else {
            return 0
        }
    }
    
    // collectionView 셀 생성 및 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        if let cafeInfo = self.searchCafeData?.data[0][indexPath.row]{
            cell.configure(with: cafeInfo)
        }
        
        return cell
    }
    
    // collectionView 셀 크기 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 318, height: 147)
    }
    
    // collectionView 셀과 셀 사이 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    // collectionView 줄과 줄 사이 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    // collectionView 셀이 선택됐을 때 처리할 작업 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // CafeDetailView 호출
        let cafeDetailView = CafeDetailView() // CafeDetailView 초기화
        navigationController?.pushViewController(cafeDetailView, animated: true)
        
    }
    
}
