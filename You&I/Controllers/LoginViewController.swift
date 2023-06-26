//
//  LoginViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/06/26.
//

import UIKit
import Then
import SnapKit
import Lottie

class LoginViewController: UIViewController {
    private let kakaoLoginBtn = UIButton().then {
        $0.setImage(UIImage(named: "카카오로그인"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let ApppleLoginBtn = UIButton().then {
        $0.setImage(UIImage(named: "애플로그인"), for: .normal)
        $0.contentMode = .scaleAspectFit


    }
    private let welecomeImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "니캉내캉로고")
    }
    
    let animationView: LottieAnimationView = {
        let animView = LottieAnimationView(name: "99228-heart2heart")
        animView.contentMode = .scaleAspectFill
        return animView
    }()
    
    private func addSubView() {
        self.view.addSubview(welecomeImg)
        self.view.addSubview(ApppleLoginBtn)
        self.view.addSubview(kakaoLoginBtn)

        // 이미지뷰의 제약 조건 설정
        welecomeImg.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(400)
        }

        // Apple 로그인 버튼의 제약 조건 설정
        ApppleLoginBtn.snp.makeConstraints {
            $0.top.equalTo(welecomeImg.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        kakaoLoginBtn.snp.makeConstraints{
            $0.top.equalTo(ApppleLoginBtn.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
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
                self.animationView.removeFromSuperview()
                self.addSubView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackground
        layout()
    }
}

