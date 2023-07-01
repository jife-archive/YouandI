//
//  TabBarController.swift
//  You&I
//
//  Created by 최지철 on 2023/07/02.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UINavigationController(rootViewController: MainViewController()) // 뷰컨 품은 네비게이션 컨트롤러
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc1.tabBarItem.image = UIImage(systemName: "house")
        let vc2 = AddViewController()
        vc2.tabBarItem.image = UIImage(systemName: "plus")
        let vc3 = CalenderViewController()
        vc3.tabBarItem.selectedImage = UIImage(systemName: "calendar.circle.fill")
        vc3.tabBarItem.image = UIImage(systemName: "calendar")
        
        vc1.title = "홈"
        vc2.title = "추가"
        vc3.title = "이번달 기록"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        self.tabBarController?.tabBar.layer.borderWidth = 0.5
        self.tabBarController?.tabBar.layer.borderColor = UIColor.darkGray.cgColor
        self.tabBarController?.tabBar.clipsToBounds = true
        self.tabBar.tintColor = .barColor
        //tabBar가 선택되지 않았을때의 색을 지정해준다.
        self.tabBar.unselectedItemTintColor = .darkGray
        
        
        setViewControllers([vc1,vc2,vc3], animated: false)

    }
    

}
