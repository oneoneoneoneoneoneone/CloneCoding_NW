//
//  HeaderView.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/19.
//

import UIKit
import SnapKit
import SwiftUI

class MainNavigationViewController: UINavigationController{
    var leftButotn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cup.and.saucer"), for: .normal)
        
        return button
        }()
    
    var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "무료!"
        
        return label
    }()
    
    var centerLeftButton: UIButton = {
        let button = UIButton()
        button.setTitle("◀︎", for: .selected)
        
        return button
    }()
    
    var centerLabel: UILabel = {
        let label = UILabel()
        label.text = "여성 인기순"
        
        return label
    }()
    
    var centerRightButton: UIButton = {
        let button = UIButton()
        button.setTitle("▶︎", for: .selected)
        
        return button
    }()
    
    var rightButotn: UIButton = {
    let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        return button
    }()
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: MainViewController())
        
        [leftButotn, leftLabel,
         centerLeftButton, centerLabel, centerRightButton,
         rightButotn
        ].forEach{
            view.addSubview($0)
        }
        
        leftButotn.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
        }
        leftLabel.snp.makeConstraints{
            $0.leading.equalTo(leftButotn.snp.trailing)
        }
        
        centerLeftButton.snp.makeConstraints{
            $0.trailing.equalTo(centerLabel.snp.leading).offset(5)
        }
        centerLabel.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
        centerRightButton.snp.makeConstraints{
            $0.leading.equalTo(centerLabel.snp.trailing).offset(5)
        }
        
        rightButotn.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
