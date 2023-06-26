//
//  LaunchScreenViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/06/26.
//

import UIKit
import Lottie
import SnapKit
import Then

class LaunchScreenViewController: UIViewController {
    
    private let animationView: LottieAnimationView = {
      let lottieAnimationView = LottieAnimationView(name: "99228-heart2heart")
      lottieAnimationView.backgroundColor = UIColor(red: 52/255, green: 144/255, blue: 220/255, alpha: 1.0)
      return lottieAnimationView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
