//
//  CalendarBasicViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/13.
//

import UIKit
import SnapKit

class BasicCollectionViewCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    let isUpdateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"circle.fill")
        imageView.tintColor = .red
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    let isIncreaseIcon = UILabel()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "제목"
        
        return label
    }()
    let isStopLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .center
        label.text = "휴재"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 3
        
        return label
    }()
    
    let writerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.text = "작가"
        
        return label
    }()
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.text = "★8.99"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [
        imageView, isUpdateIcon, isIncreaseIcon,
        titleLabel, isStopLabel,
        writerLabel, scoreLabel
        ].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }
        isUpdateIcon.snp.makeConstraints{
            $0.leading.equalTo(imageView.snp.trailing).inset(5)
            $0.bottom.equalTo(imageView.snp.top).offset(5)
            $0.width.height.equalTo(10)
        }
        isIncreaseIcon.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).inset(20)
            $0.leading.equalTo(imageView.snp.leading)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalTo(imageView)
        }
        isStopLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.width.equalTo(25)
            $0.height.equalTo(titleLabel.snp.height)
        }
        
        writerLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(imageView)
        }
        scoreLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(writerLabel.snp.trailing).offset(5)
        }
    }
    
    func setData(item: Item){
        imageView.image = UIImage()
        titleLabel.text = item.title
        writerLabel.text = item.writer
        scoreLabel.text = "★\(item.score)"
        isUpdateIcon.isHidden = !item.isUpdate
        isIncreaseIcon.isHidden = !item.isIncrease
        isStopLabel.isHidden = !item.isStop
    }
}
