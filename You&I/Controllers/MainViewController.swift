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

    private let topBackgroundView = UIView().then{
        $0.backgroundColor = .MainBackground
    }
    private let nicknameLabel = UILabel().then{
        $0.text = "마늘보단갈릭" + "님"
        $0.textColor = .black
        $0.font = .pretendard(.medium, size: 20)
        $0.numberOfLines = 0 // 여러줄의 라인을 생략하지 않고 표현하겠다는 뜻
    }
    private let welecomeLabel = UILabel().then{
        $0.text = "기억해야 할 것들을" + "\n알려드릴게요"
        $0.textColor = .systemGray6
        $0.font = .pretendard(.regular, size: 20)
        $0.numberOfLines = 0 // 여러줄의 라인을 생략하지 않고 표현하겠다는 뜻

    }
    private let memorycollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.register(MemortCardCollectionViewCell.self, forCellWithReuseIdentifier: MemortCardCollectionViewCell.identifier)
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
    }
    private let welecomeSV = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .fill
    }
    private func layout(){

        welecomeSV.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(75)
            
        }
        topBackgroundView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.top.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
        }
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: nil, action: nil)
        barButtonItem.tintColor = UIColor.white // 원하는 색상으로 변경

        self.navigationItem.rightBarButtonItem = barButtonItem

    }
    private func addSubView(){

        topBackgroundView.addSubview(welecomeSV)
        welecomeSV.addArrangedSubview(nicknameLabel)
        welecomeSV.addArrangedSubview(welecomeLabel)
        view.addSubview(topBackgroundView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainContainer // 배경색
        addSubView()
        layout()
        let LoginVC = LoginViewController()
        LoginVC.modalPresentationStyle = .fullScreen
        self.present(LoginVC,animated: true, completion: nil)
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemortCardCollectionViewCell.identifier, for: indexPath) as! MemortCardCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 48, height: 400)
    }
}
