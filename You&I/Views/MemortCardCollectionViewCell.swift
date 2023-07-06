//
//  MemortCardCollectionViewCell.swift
//  You&I
//
//  Created by 최지철 on 2023/06/27.
//

import UIKit
import SnapKit
import Then
class MemortCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "MemortCardCollectionViewCell"
    
    private let emotionImgView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "기록없는표정")?.withRenderingMode(.alwaysOriginal)
    }
    public let dateLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 14)
        $0.textColor = .black
        $0.text = "2023년 7월 6일"
    }
    public let titleLabel = UILabel().then {
        $0.font = .pretendard(.bold, size: 24)
        $0.textColor = .black
        $0.text = "제목"
    }
    public let contentlabel = UILabel().then{
        $0.font = .pretendard(.bold, size: 12)
        $0.textColor = .darkGray
        $0.text = "기록이 아직없어요!" + "\n 그날의 감정과 일들을 기록 해보세요"
    }
    public let moreButton = UIButton().then {
        $0.backgroundColor = .barColor
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    private func addSubView() {
        self.addSubview(self.emotionImgView)
        self.addSubview(self.dateLabel)
        self.addSubview(self.moreButton)
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentlabel)

    }
    private func layout(){
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
        }
        self.emotionImgView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(38)
        }

        self.moreButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        self.contentlabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.moreButton.snp.top).offset(-16)
        }
        self.dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.contentlabel.snp.top).offset(-6)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .ContinerPink
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .init(width: 0, height: 2)
        self.layer.cornerRadius = 8
        
        self.addSubView()
        self.layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
