//
//  MainNavigationViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/19.
//

import UIKit
import SnapKit
import SwiftUI

class MainNavigationView: UIView{
    var leftButotn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cup.and.saucer"), for: .normal)
        
        return button
        }()
    
    var leftView: UIView = {
        let view = UIView()
        let label = UILabel()
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble.left")
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.text = "무료!"
        
        view.addSubview(label)
        view.addSubview(imageView)
        
        label.snp.makeConstraints{
            $0.top.equalToSuperview().inset(2)
            $0.leading.equalToSuperview().inset(8)
        }
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalTo(40)
        }
        view.backgroundColor = .blue
        //let button = UIBarButtonItem(customView: view)
        return view
    }()
    
    var rightButotn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        [
            leftButotn, leftView,
            rightButotn
        ].forEach{
            addSubview($0)
        }

        leftButotn.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        leftView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(leftButotn.snp.trailing).offset(5)
        }
       
        rightButotn.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension MainNavigationView{
    @objc func setRightButtonTab(){
        
    }
}
