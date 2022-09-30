//
//  MainCollectionViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/07.
//

import UIKit
import SnapKit

class MainCollectionViewController: UIViewController{
    var VC = MainViewController()
    
    var contents: [CalendarContent] = []
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //Autoresizing - superview가 커지거나 줄어듦에 따라 subview의 크기나 위치를 조정. autolayout에서 같이 사용된다면 충돌이 날 수 있음
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //스크롤뷰안에 콜렉션뷰가 들어가기 때문에 콜렉션뷰 스크롤 방지
        
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: "BasicCollectionViewCell")
        collectionView.register(AiCollectionViewCell.self, forCellWithReuseIdentifier: "AiCollectionViewCell")
        collectionView.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: "RankCollectionViewCell")
        
        collectionView.register(AiCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AiCollectionViewHeader")

        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setLayout()
        collectionView.layer.backgroundColor = UIColor.white.cgColor
        
        setView()
        
        //data
        contents = getData()
        
        self.navigationController?.navigationBar.layer.position.y = -20
    }
    
//    override func didMove(toParent parent: UIViewController?) {
//        VC = parent?.parent as! MainViewController
//    }
//    
    @objc private func viewCookiㅜe() {
        print("쿠키굽기")
    }
    @objc private func viewSearch() {
        print("검색")
    }
    
    func getData() -> [CalendarContent]{
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
                let data = FileManager.default.contents(atPath: path),
                let list = try? PropertyListDecoder().decode([CalendarContent].self, from: data) else {return []}
                
        return list
                
    }
}


//MARK: Private Method
extension MainCollectionViewController{
    func setView(){
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
    }

}


//MARK: CompositionalLayout
extension MainCollectionViewController{
    func setLayout() -> UICollectionViewLayout{
        //UICollectionViewCompositionalLayout(section: section)
        
        
        return UICollectionViewCompositionalLayout{[weak self] sectionNumber, Environment -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}

            switch self.contents[sectionNumber].sectionType{
            case .banner:
                return self.createBannerTypeSection()
            case .basic:
                return self.createBasicTypeSection()
            case .ai:
                return self.createAiTypeSection()
            case .rank:
                return self.createAiTypeSection()
            case .update:
                return self.createBasicTypeSection()
            }
            
        }
        
    }
    
    //Section 설정
    func createBannerTypeSection() -> NSCollectionLayoutSection{
        let itemFractionalWidthFraction = 1.0 / 1.0 // horizontal 가로로 나란히 3개의 셀을 볼 수 있는 비율
        let groupFractionalHeightFraction = 1.0 / 3.4 // vertical 세로로 나란히 3.4개의 셀을 볼 수 있는 비율
        let itemInset: CGFloat = 0
        let sectionInset: CGFloat = 0
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(groupFractionalHeightFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)
        section.orthogonalScrollingBehavior = .paging   //화면 단위로 넘기기
                        
        return section
    }
    func createBasicTypeSection() -> NSCollectionLayoutSection{
        let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 가로로 나란히 3개의 셀을 볼 수 있는 비율
        let groupFractionalHeightFraction = 1.0 / 3.0 // vertical 세로로 나란히 3개의 셀을 볼 수 있는 비율
        let itemInset: CGFloat = 3
        let sectionInset: CGFloat = 10
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(groupFractionalHeightFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)
        
        return section
    }
    func createAiTypeSection() -> NSCollectionLayoutSection{
        let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 가로로 나란히 3개의 셀을 볼 수있는 비율. group에 count 값을 설정하면 의미 없음
        let groupFractionalHeightFraction = 1.0 / 3.0 // vertical 세로로 나란히 3개의 셀을 볼 수 있는 비율
        let itemInset: CGFloat = 5
        let sectionInset: CGFloat = 10
        
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(groupFractionalHeightFraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])//, count: 3) //count - 한번에 볼 수 있는 cell 수
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInset, bottom: 0, trailing: sectionInset)
        section.orthogonalScrollingBehavior = .continuous   //자연스러운 스크롤
        let sectionHeader = self.createSectionHeaader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createSectionHeaader() -> NSCollectionLayoutBoundarySupplementaryItem{
        let sectionInset: CGFloat = 10
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: sectionInset, leading: sectionInset, bottom: sectionInset, trailing: sectionInset)
        
        return sectionHeader
    }

}


//MARK: UICollectionViewDataSource
extension MainCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return contents[section].contentItem.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch contents[indexPath.section].sectionType{
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as? HeaderCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])
            
            return cell ?? UICollectionViewCell()
        case .basic:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCollectionViewCell", for: indexPath) as? BasicCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])
            
            return cell ?? UICollectionViewCell()
        case .ai:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AiCollectionViewCell", for: indexPath) as? AiCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])
                
            return cell ?? UICollectionViewCell()
        case .rank, .update:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankCollectionViewCell", for: indexPath) as? RankCollectionViewCell
            cell?.setData(item: contents[indexPath.section].contentItem[indexPath.row])
                
            return cell ?? UICollectionViewCell()
            
        }
    
        
    }
    
    //@@@@섹션 개수 설정 필수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    //헤더뷰 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AiCollectionViewHeader", for: indexPath) as? AiCollectionViewHeader else { fatalError("Error") }
                
                switch contents[indexPath.section - 1].sectionType{
                case .ai:
                    headerView.iconLabel.text = "Ai"
                    headerView.iconLabel.tintColor = .red
                    headerView.titleLabel.text = "Ai가 @@님한테 골라주는 어쩌고"
                case .rank:
                    headerView.iconLabel.text = "♡"
                    headerView.iconLabel.tintColor = .green
                    headerView.titleLabel.text = "##독자님이 좋아하는 웹툰 랭킹!!!"
                default:
                    headerView.rightButton.setImage(UIImage(systemName: ""), for: .normal)
                }
                return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
}


//MARK: UICollectionViewDelegateFlowLayout
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = collectionView.frame.width
//        //let height: CGFloat = collectionView.frame.height/4 - 32
//
//        return CGSize(width: width, height: width)
//    }
}


//MARK: UIScrollViewDelegate

extension MainCollectionViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        var headerConstant = self.collectionView.contentOffset.y
        //var collectionConstant = CGFloat()
        
        //scrollView 아래로 스크롤시 top 고정 (최소값 0)
        headerConstant = headerConstant < 1 ? -20 : headerConstant
        //scrollView 위로 스크롤시 top 고정 (최대값 HeaderMinHeight)
        headerConstant = headerConstant > Const.Size.HeaderMaxHeight ? Const.Size.HeaderMaxHeight : headerConstant
        
        //collectionConstant = Const.Size.HeaderMaxHeight - ((headerConstant - 0) / (Const.Size.HeaderMinHeight)) * (Const.Size.HeaderMaxHeight - Const.Size.HeaderMinHeight)
        
        self.navigationController?.navigationBar.layer.position.y = headerConstant
        self.navigationController?.setNavigationBarHidden(headerConstant < Const.Size.HeaderMaxHeight, animated: true)
    }
}
