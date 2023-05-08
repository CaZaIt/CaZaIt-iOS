import UIKit

class CafeDetailView: UIViewController {

    private let headerViewHeight: CGFloat = 100
    private let labelHeight: CGFloat = 30 // 라벨의 높이 값 추가
    private let cellId = "cell"

    private var tableView: UITableView!
    private var headerView: UIView!
    private var headerLabel: UILabel! // 헤더 뷰에 추가할 라벨
    private var headerViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setupTableView()
        setupHeaderView()
        setupHeaderLabel() // 라벨 추가하는 함수 호출
        setupHeaderViewConstraints()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderHeight = headerViewHeight // Sticky Header를 위한 설정
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.sectionHeaderTopPadding = 0

        view.addSubview(tableView)
        // Add constraints to make the table view fill the safe area
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }
    



    private func setupHeaderView() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerViewHeight))
        headerView.backgroundColor = .systemBlue

        tableView.addSubview(headerView) // tableHeaderView 대신 tableView에 추가

    }
    

    private func setupHeaderViewConstraints() {
        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerViewHeight)
        headerViewHeightConstraint.isActive = true

        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        headerView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
    }


    private func setupHeaderLabel() {
        headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.bounds.width - 32, height: labelHeight))
        headerLabel.text = "제주몰빵"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textColor = .white

        headerView.addSubview(headerLabel)
    }
}

extension CafeDetailView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let segmentControl = UISegmentedControl(items: ["First", "Second"])
        segmentControl.frame = CGRect(x: 16, y: 0, width: cell.contentView.bounds.width - 32, height: 100)
        cell.contentView.addSubview(segmentControl)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y + tableView.safeAreaInsets.top
        guard let headerViewHeightConstraint = headerViewHeightConstraint else {
            return
        }

        let newHeaderViewHeight = headerViewHeightConstraint.constant - y
        //let newHeaderViewHeight = headerViewHeight - y


        if newHeaderViewHeight < labelHeight { // 헤더 높이가 라벨 높이보다 작으면
            headerLabel.alpha = 0 // 라벨 숨김
        } else { // 그렇지 않으면
            headerLabel.alpha = 1 // 라벨 보임
        }

        if newHeaderViewHeight < 0 { // 헤더 높이가 0보다 작으면
            headerViewHeightConstraint.constant = 0 // 헤더 높이를 0으로 설정
        } else if newHeaderViewHeight > headerViewHeight { // 헤더 높이가 최대 높이보다 크면
            headerViewHeightConstraint.constant = headerViewHeight // 헤더 높이를 최대 높이로 설정
        } else { // 그렇지 않으면
            headerViewHeightConstraint.constant = newHeaderViewHeight // 새로운 높이로 헤더 높이 업데이트
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerViewHeight
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 밝은 배경색일 경우에는 .darkContent
    }

}
