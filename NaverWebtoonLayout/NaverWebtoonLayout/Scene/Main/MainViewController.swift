//
//  MainViewController.swift
//  NaverWebtoonLayout
//
//  Created by hana on 2022/09/21.
//

import UIKit
import SnapKit
import SwiftUI

class MainViewController: UIViewController {
    
    var dataSource: [MainCollectionViewModel] = []
    var dataSourceVC: [UIViewController] = []
    let days = ["신작", "월", "화", "수", "목", "금", "토", "일", "매일+", "완결"]
      
    var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    //navigation
    public var topView = MainNavigationView()
    
    var centerLeftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("◀︎", for: .normal)
        
        return button
    }()
    
    var centerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "여성 인기순"
        
        return label
    }()
    
    var centerRightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("▶︎", for: .normal)
        
        return button
    }()
    lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.tintColor = .label
        [
            centerLabel, centerLeftButton, centerRightButton
        ]
        .forEach{
            view.addSubview($0)
        }
        
        centerLabel.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }
        centerLeftButton.snp.makeConstraints{
            $0.trailing.equalTo(centerLabel.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
        }
        centerRightButton.snp.makeConstraints{
            $0.leading.equalTo(centerLabel.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
        
        return view
    }()
    

    //day콜렉션 메뉴
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "DayCollectionViewCell")
        
        return collectionView
    }()

    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        return vc
    }()
    
    //MARK: override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        
        setupDataSource()
        
        setupPageViewControllers()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        //view.addSubview(topView)
        view.addSubview(collectionView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
//        topView.layer.zPosition = 1
//        topView.snp.makeConstraints{
//            $0.top.equalToSuperview().inset(20)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(30)
//
//        }
        collectionView.snp.makeConstraints{
            //$0.edges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
            
        }
        pageViewController.view.snp.makeConstraints{
            $0.top.equalTo(collectionView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //페이지 초기화
        currentPage = 0
        
    }
    
//    func setIsTopView(isTop: Bool){
//        self.topView.leftView.alpha = isTop ? 0.0 : 100.0
//        self.topView.tintColor = isTop ? .white : .label
//    }
}


//MARK: private

extension MainViewController{
    
    private func setNavigation(){
        self.navigationItem.titleView = centerView
        self.navigationItem.titleView?.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets)
        }

        
        self.navigationController?.navigationBar.layer.position.y = 0
    }

    // viewDidLoad에서 호출
    private func setupPageViewControllers() {

//        var i = 0
        dataSource.forEach { _ in
            let vc = MainCollectionViewController()
//            let label = UILabel()
//            label.text = "\(i)"
//            label.font = .systemFont(ofSize: 56, weight: .bold)
//            i += 1
//
//            vc.view.addSubview(label)
//            label.snp.makeConstraints { make in
//                make.center.equalToSuperview()
//            }
            dataSourceVC += [vc]
//            vc.didMove(toParent: self)
        }
    }
    
    ///dataSource에 MyCollectionViewModel 셋팅
    private func setupDataSource() {
        for i in 0...(days.count - 1) {
            var model = MainCollectionViewModel(id: i)
            model.title = days[i]
            dataSource += [model]
        }
    }
    
    ///현재 페이지가 변경될 때 각 컨트롤(페이지뷰, 콜렉션부)에 업데이트
    private func bind(oldValue: Int, newValue: Int) {

        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers(
            [dataSourceVC[currentPage]],
            direction: direction,
            animated: true,
            completion: nil
        )

        // pageViewController에서 paging한 경우
        collectionView.selectItem(
            at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    ///ColelctionViewCell안에 요소를 tap할 때 반응 이벤트 바인딩
    func didTapCell(at indexPath: IndexPath) {
          currentPage = indexPath.item
      }
    
    @objc func setRightButtonTab(){
        
    }
}


//MARK: CollectionView Delegate & DataSource

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/CGFloat(days.count), height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didTapCell(at: indexPath)
    }
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell
        cell?.model = dataSource[indexPath.item]

        return cell ?? UICollectionViewCell()
    }
    
}


//MARK: PageViewController Delegate & DataSource

extension MainViewController: UIPageViewControllerDataSource{
    //뒤로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController : UIViewController) -> UIViewController? {
        guard let index = dataSourceVC.firstIndex(of: viewController),
        index + 1 < dataSourceVC.count   //마지막페이지 이상 넘어가면
        else { return nil }
        return dataSourceVC[index + 1]
    }
    //앞으로넘길때 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataSourceVC.firstIndex(of: viewController) else { return nil}
        let previousIndex = index - 1
        if previousIndex < 0{
            return nil
        }
        return dataSourceVC[previousIndex]
    }
}

extension MainViewController: UIPageViewControllerDelegate{
    //현재 페이지 로드가 끝났을 때 호출
    //pageViewController에서 값이 변경될 때 collectionView에도 적용
    //@@@@@@@@@@@위 dataSource에서 처리하면 캐싱이 되어 index값이 모두 불리지 않으므로, delegate에서 따로 처리가 필요 @@@@ <이건 먼소리고 캐싱??
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = dataSourceVC.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}
