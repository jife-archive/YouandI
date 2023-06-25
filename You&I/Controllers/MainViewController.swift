//
//  MainViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/06/23.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {


    private let nicknameLabel = UILabel().then{
        $0.text = "마늘보단갈릭" + "님"
        $0.textColor = .black
        $0.numberOfLines = 0 // 여러줄의 라인을 생략하지 않고 표현하겠다는 뜻
    }
    private let welecomeLabel = UILabel().then{
        $0.text = "기억해야 할 것들을\n알려드릴게요"
        $0.textColor = .systemGray5
        $0.numberOfLines = 0 // 여러줄의 라인을 생략하지 않고 표현하겠다는 뜻
    }
    private let welecomeSV = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 0
    }
    private func layout(){
        self.nicknameLabel.snp.makeConstraints{
            $0.height.equalTo(28)
        }
        self.welecomeLabel.snp.makeConstraints{
            $0.height.equalTo(28)
        }
        view.addSubview(welecomeSV)
        welecomeSV.addArrangedSubview(nicknameLabel)
        welecomeSV.addArrangedSubview(welecomeLabel)
        welecomeSV.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            
        }
        navigationItem.title = "니캉내캉"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: nil, action: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackground // 배경색
        layout()
    }
}
