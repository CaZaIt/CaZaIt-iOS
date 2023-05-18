//import UIKit
//
//class CafeDetailView: UIViewController {
//
//    private let headerViewHeight: CGFloat = 100
//    private let labelHeight: CGFloat = 30 // 라벨의 높이 값 추가
//    private let cellId = "cell"
//
//    private var tableView: UITableView!
//    private var headerView: UIView!
//    private var headerLabel: UILabel! // 헤더 뷰에 추가할 라벨
//    private var headerViewHeightConstraint: NSLayoutConstraint!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .black
//
//        setupTableView()
//        setupHeaderView()
//        setupHeaderLabel() // 라벨 추가하는 함수 호출
//        setupHeaderViewConstraints()
//    }
//
//    private func setupTableView() {
//        tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
//        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.sectionHeaderHeight = headerViewHeight // Sticky Header를 위한 설정
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//
//        tableView.contentInsetAdjustmentBehavior = .never
//
//        tableView.sectionHeaderTopPadding = 0
//
//        view.addSubview(tableView)
//        // Add constraints to make the table view fill the safe area
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//
//    }
//
//
//
//
//    private func setupHeaderView() {
//        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerViewHeight))
//        headerView.backgroundColor = .systemBlue
//
//        tableView.addSubview(headerView) // tableHeaderView 대신 tableView에 추가
//
//    }
//
//
//    private func setupHeaderViewConstraints() {
//        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerViewHeight)
//        headerViewHeightConstraint.isActive = true
//
//        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//
//        headerView.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
//    }
//
//
//    private func setupHeaderLabel() {
//        headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.bounds.width - 32, height: labelHeight))
//        headerLabel.text = "제주몰빵"
//        headerLabel.textAlignment = .center
//        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        headerLabel.textColor = .white
//
//        headerView.addSubview(headerLabel)
//    }
//}
//
//extension CafeDetailView: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//
//        let segmentControl = UISegmentedControl(items: ["First", "Second"])
//        segmentControl.frame = CGRect(x: 16, y: 0, width: cell.contentView.bounds.width - 32, height: 100)
//        cell.contentView.addSubview(segmentControl)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 800
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y = scrollView.contentOffset.y + tableView.safeAreaInsets.top
//        guard let headerViewHeightConstraint = headerViewHeightConstraint else {
//            return
//        }
//
//        let newHeaderViewHeight = headerViewHeightConstraint.constant - y
//        //let newHeaderViewHeight = headerViewHeight - y
//
//
//        if newHeaderViewHeight < labelHeight { // 헤더 높이가 라벨 높이보다 작으면
//            headerLabel.alpha = 0 // 라벨 숨김
//        } else { // 그렇지 않으면
//            headerLabel.alpha = 1 // 라벨 보임
//        }
//
//        if newHeaderViewHeight < 0 { // 헤더 높이가 0보다 작으면
//            headerViewHeightConstraint.constant = 0 // 헤더 높이를 0으로 설정
//        } else if newHeaderViewHeight > headerViewHeight { // 헤더 높이가 최대 높이보다 크면
//            headerViewHeightConstraint.constant = headerViewHeight // 헤더 높이를 최대 높이로 설정
//        } else { // 그렇지 않으면
//            headerViewHeightConstraint.constant = newHeaderViewHeight // 새로운 높이로 헤더 높이 업데이트
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return headerViewHeight
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent // 밝은 배경색일 경우에는 .darkContent
//    }
//
////}
//
//import UIKit
//import MXParallaxHeader
//
//class CafeDetailView: UITableViewController, MXParallaxHeaderDelegate {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 테이블뷰에 적용할 헤더뷰 생성
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
//        headerView.backgroundColor = UIColor.white
//
//        // 헤더뷰에 이미지 추가
//        let imageView = UIImageView(frame: headerView.bounds)
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "big_cafe")
//        headerView.addSubview(imageView)
//
//        // 헤더뷰에 라벨 추가
//        let label = UILabel(frame: CGRect(x: 0, y: headerView.bounds.height - 50, width: headerView.bounds.width, height: 50))
//        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
//        label.textColor = UIColor.white
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.text = "Parallax Header"
//        headerView.addSubview(label)
//
//        // TableView의 Header View에 MXParallaxHeader 적용
//        tableView.parallaxHeader.view = headerView
//        tableView.parallaxHeader.height = 200
//        tableView.parallaxHeader.mode = .fill
//        tableView.parallaxHeader.minimumHeight = 0
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        // MXParallaxHeaderDelegate 설정
//        tableView.parallaxHeader.delegate = self
//    }
//
//    // MARK: - MXParallaxHeaderDelegate
//
//    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
//        let progress = parallaxHeader.progress // 스크롤 진행도 (0 ~ 1)
//        let scale = 1 + (progress * 0.5) // 확대/축소 비율 (1 ~ 1.5)
//        let transform = CGAffineTransform(scaleX: scale, y: scale)
//        parallaxHeader.view?.subviews.first?.transform = transform // 첫 번째 서브뷰 (이미지 뷰)에 transform 적용
//    }
//
//
//    // MARK: - UITableViewDataSource
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Cell \(indexPath.row)"
//        return cell
//    }
////}
//
//import SwiftUI
//import MXParallaxHeader
//
//class CafeDetailView: MXScrollViewController, MXScrollViewDelegate {
//
//    var headerHeight: CGFloat = 0
//    var headerMinimumHeight: CGFloat = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        scrollView.parallaxHeader.minimumHeight = headerMinimumHeight
//        scrollView.parallaxHeader.height = headerHeight
//        scrollView.delegate = self
//    }
//
//    func updateHeaderHeight(animated: Bool = false) {
//        let height = headerHeight
//
//        if animated {
//            UIView.animate(withDuration: 0.3) { [weak self] in
//                self?.scrollView.parallaxHeader.height = height
//            }
//        } else {
//            scrollView.parallaxHeader.height = height
//
//            view.setNeedsLayout()
//            UIView.performWithoutAnimation {
//                view.layoutIfNeeded()
//                scrollView.contentOffset.y = scrollView.contentInset.top - scrollView.adjustedContentInset.top
//            }
//        }
//    }
//}
//
//class ParallaxViewControllerHeader: UIViewController {
//
//    let controller: UIViewController
//    var heightConstraint: NSLayoutConstraint?
//
//    init(header: UIViewController) {
//        controller = header
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.clipsToBounds = false
//
//        addChild(controller)
//        view.addSubview(controller.view)
//        controller.didMove(toParent: self)
//
//        let height = controller.view.systemLayoutSizeFitting(CGSize(width: UIScreen.main.bounds.width, height: .infinity)).height
//        let heightConstraint = controller.view.heightAnchor.constraint(equalToConstant: height)
//
//        controller.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            //controller.view.topAnchor.constraint(equalTo: view.topAnchor),
//            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            heightConstraint,
//        ])
//        self.heightConstraint = heightConstraint
//    }
//
//    func updateHeight(animated: Bool = false) -> CGFloat {
//        heightConstraint?.isActive = false
//        controller.view.setNeedsLayout()
//        controller.view.layoutIfNeeded()
//        let height = controller.view.systemLayoutSizeFitting(CGSize(width: UIScreen.main.bounds.width, height: .infinity)).height
//        heightConstraint?.constant = height
//        heightConstraint?.isActive = true
//
//        if animated {
//            UIView.animate(withDuration: 0.3) { [weak self] in
//                self?.view.layoutIfNeeded()
//            }
//        }
//
//        return height
//    }
//}
//
//struct ParallaxHeaderView<Header: View, Content: View>: UIViewControllerRepresentable {
//
//    @Binding var update: Bool
//    let header: Header
//    let content: Content
//
//    init(update: Binding<Bool>, @ViewBuilder header: () -> Header, @ViewBuilder content: () -> Content) {
//        self._update = update
//        self.header = header()
//        self.content = content()
//    }
//
////    func makeUIViewController(context: Context) -> ParallaxViewController {
////        let vc = ParallaxViewController()
////        vc.childViewController = UIViewController.hostingController {
////            content
////        }
////        updateUIViewController(vc, context: context)
////        return vc
////    }
//
//    func makeUIViewController(context: Context) -> CafeDetailView {
//        let vc = CafeDetailView()
//        vc.childViewController = UIHostingController(rootView: content)
//        updateUIViewController(vc, context: context)
//        return vc
//    }
//
////
////    func updateUIViewController(_ vc: ParallaxViewController, context: Context) {
////        vc.headerViewController = ParallaxViewControllerHeader(header: UIViewController.hostingController {
////            header
////        })
////        if let height = (vc.headerViewController as? ParallaxViewControllerHeader)?.updateHeight(animated: true) {
////            vc.headerHeight = height
////            vc.updateHeaderHeight(animated: true)
////        }
////    }
//
//    func updateUIViewController(_ vc: CafeDetailView, context: Context) {
//        vc.headerViewController = ParallaxViewControllerHeader(header: UIHostingController(rootView: header))
//        if let height = (vc.headerViewController as? ParallaxViewControllerHeader)?.updateHeight(animated: true) {
//            vc.headerHeight = height
//            vc.updateHeaderHeight(animated: true)
//        }
//    }
//
//}
//
//struct ParallaxHeaderPreview: View {
//
//    @State var texts: [String] = [NSUUID().uuidString]
//    @State var update: Bool = false
//
//    var body: some View {
//        ParallaxHeaderView(update: $update) {
//            VStack {
//                Text("Header")
//                    .font(.system(size: 17, weight: .bold))
//                    .padding(.vertical)
//                ForEach(texts, id: \.self) {
//                    Text($0)
//                        .padding(.vertical)
//                }
//                HStack(spacing: 60) {
//                    Button(action: {
//                        if !texts.isEmpty {
//                            texts.removeLast()
//                            update.toggle()
//                        }
//                    }, label: {
//                        Image(systemName: "minus")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30)
//                            .frame(height: 30)
//                    })
//                    Button(action: {
//                        texts.append(NSUUID().uuidString)
//                        update.toggle()
//                    }, label: {
//                        Image(systemName: "plus")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30)
//                            .frame(height: 30)
//                    })
//                }
//                .padding()
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color.blue.opacity(0.5))
//        } content: {
//            VStack(spacing: 0) {
//                HStack {
//                    Text("Content")
//                        .font(.system(size: 17, weight: .bold))
//                        .padding(.vertical)
//                }
//                .frame(maxWidth: .infinity)
//                .frame(height: 44)
//                .background(Color.green.opacity(0.5))
//                List {
//                    ForEach(0 ..< 100) {
//                        Text("\($0)")
//                    }
//                    .listRowBackground(Color.green)
//                }
//            }
//        }
//    }
//}
//
//struct ParallaxHeaderView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ParallaxHeaderPreview()
//    }
////}
//import UIKit
//
//class ParaㅊllaxViewController: UIViewController, UIScrollViewDelegate {
//    var scrollView: UIScrollView!
//    var headerView: UIView!
//    var headerHeightConstraint: NSLayoutConstraint!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        scrollView = UIScrollView()
//        scrollView.delegate = self
//        view.addSubview(scrollView)
//
//        headerView = UIView()
//        headerView.backgroundColor = .blue
//        scrollView.addSubview(headerView)
//
//        // 헤더 뷰의 레이아웃 제약 조건 설정
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 200)
//        headerHeightConstraint.isActive = true
//
//        // 헤더에 추가될 콘텐츠 뷰
//        let contentView = UIView()
//        contentView.backgroundColor = .white
//        scrollView.addSubview(contentView)
//
//        // 콘텐츠 뷰의 레이아웃 제약 조건 설정
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
//
//        // 헤더와 콘텐츠에 내용을 추가해 보겠습니다.
//        let headerLabel = UILabel()
//        headerLabel.text = "Parallax Header"
//        headerLabel.textColor = .white
//        headerLabel.textAlignment = .center
//        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        headerView.addSubview(headerLabel)
//        headerLabel.translatesAutoresizingMaskIntoConstraints = false
//        headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
//        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
//
//        let contentLabel = UILabel()
//        contentLabel.text = "Scrollable Content"
//        contentLabel.textColor = .black
//        contentLabel.textAlignment = .center
//        contentView.addSubview(contentLabel)
//        contentLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//    }
//
//    // 스크롤 이벤트 처리
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        headerHeightConstraint.constant = max(-offsetY, 200)
//    }
//}
//
//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // ParallaxViewController 인스턴스 생성
//        let parallaxVC = ParallaxViewController()
//
//        // ParallaxViewController를 자식
import UIKit

class CafeDetailView: UIViewController, UIScrollViewDelegate {
    private let scrollView = UIScrollView()
    private let headerView = UIView()
    private let segmentedControl = UISegmentedControl()
    private let parallaxImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIScrollView 설정
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // 헤더뷰 설정
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerView)
        
        // 피럴랙스 효과를 가진 이미지 설정
        parallaxImageView.image = UIImage(named: "big_cafe") // 피럴랙스 이미지 설정
        parallaxImageView.contentMode = .scaleAspectFill
        parallaxImageView.clipsToBounds = true
        parallaxImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(parallaxImageView)
        
        parallaxImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        parallaxImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        parallaxImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        parallaxImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        parallaxImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        headerView.topAnchor.constraint(equalTo: parallaxImageView.bottomAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // 세그먼트 컨트롤 설정
        segmentedControl.insertSegment(withTitle: "Segment 1", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Segment 2", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(segmentedControl)
        segmentedControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16).isActive = true

        // 콘텐츠 높이 설정
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 400)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        // 이미지의 위치를 스크롤 속도보다 더 느리게 이동하도록 설정
        parallaxImageView.transform = CGAffineTransform(translationX: 0, y: -offsetY/2)
    }
}

