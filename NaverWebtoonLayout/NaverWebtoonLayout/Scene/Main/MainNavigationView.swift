//
//  MainNavigationViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/19.
//

import UIKit
import SnapKit
import SwiftUI

class MainNavigationView: UINavigationController{
    var leftButotn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cup.and.saucer"), for: .normal)
        button.sizeToFit()
        
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
            $0.width.height.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(25)
        }
        
        return view
    }()
    
    var rightButotn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.sizeToFit()
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarHidden(true, animated: true)
        self.navigationBar.layer.position.y = 0
        
        [
            leftButotn, leftView,
            rightButotn
        ].forEach{
            view.addSubview($0)
        }

        leftButotn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(10)
            $0.height.equalTo(navigationBar)
        }
        leftView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(leftButotn.snp.trailing).offset(10)
            $0.height.equalTo(navigationBar)
        }
       
        rightButotn.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(navigationBar)
        }
    }
    
    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        self.leftView.alpha = hidden ? 0.0 : 100.0
        self.leftButotn.tintColor = hidden ? .white : .label
        self.rightButotn.tintColor = hidden ? .white : .label
    }
    
}


extension MainNavigationView{
    @objc func setRightButtonTab(){
        
    }
}
