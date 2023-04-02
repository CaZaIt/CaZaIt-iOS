//
//  ViewController.swift
//  CaZait-iOS
//
//  Created by 강석호 on 2023/04/02.
//

import Foundation
import UIKit


class TapBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .black
        tabBar.tintColor = .gray
        tabBar.unselectedItemTintColor = .white
       // 인스턴스화
        let vc1 = MainVC()
        let vc2 = MapVC()
        let vc3 = MyPageVC()
        let vc4 = MoreVC()
        
        // 각 tab bar의 viewcontroller 타z이틀 설정
        vc1.title = ""
        vc1.tabBarItem.image = UIImage(named: "home")
        vc2.title = ""
        vc2.tabBarItem.image = UIImage(named: "map")
        vc3.title = ""
        vc3.tabBarItem.image = UIImage(named: "person")
        vc4.title = ""
        vc4.tabBarItem.image = UIImage(named: "add")
        
        
        // 위에 타이틀 text를 항상 크게 보이게 설정
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .always
        
       // navigationController의 root view 설정
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
        
    }
}
