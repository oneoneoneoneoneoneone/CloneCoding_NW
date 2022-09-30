//
//  CalendarRankViewCell.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/13.
//

import UIKit
import SnapKit

class RankCollectionViewCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName:"questionmark")
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "1"
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "제목"
        
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "설명"
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        [imageView, rankLabel, titleLabel, descriptionLabel].forEach{
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(180)
        }
        
        rankLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).inset(20)
            $0.leading.equalTo(imageView).offset(5)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalTo(rankLabel.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(imageView)
            $0.trailing.equalToSuperview()
        }
    }
    
    func setData(item: Item){
        imageView.image = UIImage()
        //rankLabel.text = ""
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

