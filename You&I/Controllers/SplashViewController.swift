//
//  SplashViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/06/27.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    let animationView: LottieAnimationView = {
        let animView = LottieAnimationView(name: "99228-heart2heart")
        animView.contentMode = .scaleAspectFill
        return animView
    }()
    private func layout() {
        self.view.addSubview(animationView)
        
        // 애니메이션뷰의 제약 조건 설정
        animationView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.centerY.equalToSuperview()
        }
        
        animationView.play { [weak self] finished in
            guard let self = self else { return }
            
            // 애니메이션이 종료된 후에 이미지뷰와 버튼을 추가하고 제약 조건을 설정합니다.
            if finished {
                let sideniavigationController = UINavigationController(rootViewController: TabBarController())
                let LoginVC = sideniavigationController
                LoginVC.navigationBar.isHidden = true
                LoginVC.modalPresentationStyle = .fullScreen
                self.present(LoginVC,animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .MainBackground

        layout()
    }
    
}
