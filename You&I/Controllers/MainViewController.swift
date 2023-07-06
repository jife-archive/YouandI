//
//  MainViewController.swift
//  You&I
//
//  Created by 최지철 on 2023/06/23.
//

import UIKit
import SnapKit
import Then
import SideMenu

class MainViewController: UIViewController {
    private let blurImgView = UIImageView()

    private let bottomLabel = UILabel().then{
        $0.text="아래 버튼을 눌러 오늘의 일을 기록하세요!"
        $0.textColor = .darkGray
        $0.font = .pretendard(.regular, size: 15)
        $0.numberOfLines = 0

    }
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
        $0.showsHorizontalScrollIndicator = false
    }
    private let welecomeSV = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .fill
    }
    private func layout(){
        bottomLabel.snp.makeConstraints{
            $0.bottom.equalTo(memorycollectionView).offset(100)
            $0.centerX.equalToSuperview()

        }
        memorycollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(207)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(400)
        }
        view.addSubview(blurImgView)
         blurImgView.snp.makeConstraints {
             $0.edges.equalToSuperview()
         }
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
         barButtonItem.target = self
         barButtonItem.action = #selector(SideMenuBtnClick)
         self.navigationItem.rightBarButtonItem = barButtonItem
    }
    private func addSubView(){
        topBackgroundView.addSubview(welecomeSV)
        welecomeSV.addArrangedSubview(nicknameLabel)
        welecomeSV.addArrangedSubview(welecomeLabel)
        view.addSubview(topBackgroundView)
        view.addSubview(memorycollectionView)
        view.addSubview(bottomLabel)
    }
    private func blureffect(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        self.blurImgView.addSubview(blurView)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let innerVisualEffectView = UIVisualEffectView(effect: vibrancyEffect)
        innerVisualEffectView.frame = self.view.frame
        blurView.contentView.addSubview(innerVisualEffectView)
        self.view.addSubview(blurImgView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainContainer // 배경색
        addSubView()
        layout()
        blureffect()
        blurImgView.isHidden = true
        self.memorycollectionView.delegate = self
        self.memorycollectionView.dataSource = self
      /*  let LoginVC = LoginViewController()
        LoginVC.modalPresentationStyle = .fullScreen
        self.present(LoginVC,animated: true, completion: nil)*/
    }
    @objc private func SideMenuBtnClick() {
        let sideMenuViewController = SideMenuViewController()
        let menu = SideMenuNavigationController(rootViewController: sideMenuViewController)
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemortCardCollectionViewCell.identifier, for: indexPath) as! MemortCardCollectionViewCell

        if indexPath.row == 0{
            cell.moreButton.isHidden = true
        }
        else{
            cell.moreButton.isHidden = false
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 24, height: 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: 24, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 48, height: 390)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = self.view.frame.width - 48 + 12
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
    
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
    
}
extension MainViewController: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        blurImgView.isHidden = false
        self.tabBarController?.tabBar.isHidden = true

    }
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        blurImgView.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
}


