//
//  RectCollectionViewCell.swift
//  StickyMenuApp
//
//  Created by hana on 2022/09/21.
//

import UIKit
import RxSwift

class DayCollectionViewCell: UICollectionViewCell{
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    var bag = DisposeBag()
    
    var model: MainCollectionViewModel? { didSet { bind() } }

    //let imageView = UIImageView()
    lazy var contentsView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white

        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.text = "월"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configure()
    }
    
    override var isSelected: Bool {
        didSet {
            contentsView.backgroundColor = isSelected ? .green : .white
            titleLabel.textColor = isSelected ? .green : .label
        }
    }
    
    private func configure() {
        
        addSubview(contentsView)
        addSubview(titleLabel)

        contentsView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }

        titleLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    private func bind() {
          titleLabel.text = model?.title ?? ""
      }
}
