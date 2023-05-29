//
//  SearchView.swift
//  CaZait-iOS
//
//  Created by 강민수 on 2023/05/16.
//

import Foundation
import UIKit

class SearchView: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
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
        setupSearchTableView()
        setupSearchCollectionView()
    }
    
    func setupNavigation() {
        // 네비게이션 바에 UISearchBar 추가
        navigationItem.titleView = searchBar
        
        // 네비게이션 색 변경 실패
//        navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1) // 원하는 배경색으로 변경
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        
        // 내비게이션 바 스타일 변경
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupSearchTableView() {
        view.addSubview(searchTableView)
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupSearchCollectionView() {
        view.addSubview(searchCollectionView)
        
        searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        //초기에는 무조건 연관검색어가 나와야하므로 검색버튼을 클릭해서 나오는 collectionView는 히든처리합니다.
        searchCollectionView.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
        self.navigationController?.navigationBar.barStyle = .black
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
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
        
        //검색텍스트가 변경되었으므로 searchTabletionView를 보여줍니다.
        searchTableView.isHidden = false
        searchCollectionView.isHidden = true
        
        updateAutoCompletionResults(for: searchText)
        print("Search keyword: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 버튼을 클릭했을 때의 동작을 처리합니다.
        
        //검색버튼을 클릭했으므로 searchCollectionView를 보여줍니다.
        searchTableView.isHidden = true
        searchCollectionView.isHidden = false
        searchBar.resignFirstResponder() // 키보드 내리기
        
        performSearch(with: searchBar.text)
    }
    
    // 자동완성 결과를 업데이트하는 로직을 구현합니다.
    func updateAutoCompletionResults(for searchText: String) {
        // 검색어에 따라 자동완성 결과를 가져오는 로직을 구현합니다.
        
        // 예를 들어 API 호출 또는 데이터 소스에서 필터링 등을 수행할 수 있습니다.
        // 가져온 결과를 화면에 표시하는 방식은 사용하고 있는 데이터 구조에 따라 다를 수 있습니다.
    }
    
    // 검색 동작을 처리하는 로직을 구현합니다.
    func performSearch(with searchText: String?) {
        // 검색어를 사용하여 검색 동작을 수행합니다.
        if let searchText = searchText {
            print("Performed search with: \(searchText)")
        } else {
            print("No search text entered.")
        }
        // 예를 들어 API 호출, 데이터베이스 쿼리 등을 수행할 수 있습니다.
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource{
    
    //mainTableView의 섹션의 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //mainTableView의 각 섹션 마다 cell row 숫자의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    //mainTableView의 각 센션 마다 사용할 cell의 종류
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.navigationController = navigationController
        
        return cell
    }

    //mainTableViewCell의 높이를 지정한다.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
}


extension SearchView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    // collectionView 셀 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 13
    }
    
    // collectionView 셀 생성 및 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        
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
        print("Cell \(indexPath.item) selected")
        
        // CafeDetailView 호출
        let cafeDetailView = CafeDetailView() // CafeDetailView 초기화
        navigationController?.pushViewController(cafeDetailView, animated: true)
        
    }
    
}
