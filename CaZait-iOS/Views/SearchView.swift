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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        searchBar.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        
        setupNavigation()
        setupSearchTableView()
    }
    
    func setupNavigation() {
        // 네비게이션 바에 UISearchBar 추가
        navigationItem.titleView = searchBar
        
        // 네비게이션 색 변경 실패
//        if let navigationBar = self.navigationController?.navigationBar {
//            navigationBar.barTintColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)
//        }
        
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
        updateAutoCompletionResults(for: searchText)
        print("Search keyword: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 버튼을 클릭했을 때의 동작을 처리합니다.
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
