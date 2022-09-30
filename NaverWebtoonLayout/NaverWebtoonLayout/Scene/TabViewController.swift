//
//  TabViewController.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/07.
//

import UIKit

class TabViewController: UITabBarController {
    lazy var calendarItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "웹툰"
        item.image = UIImage(systemName: "calendar")
        item.selectedImage = UIImage(systemName: "calendar.fill")
        
        return item
    }()
    
    lazy var endItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "추천완결"
        item.image = UIImage(systemName: "book")
        item.selectedImage = UIImage(systemName: "book.fill")
        
        return item
    }()
    
    lazy var starItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "베스트도전"
        item.image = UIImage(systemName: "star.square")
        item.selectedImage = UIImage(systemName: "star.square.fill")
        
        return item
    }()
    
    lazy var smileItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "MY"
        item.image = UIImage(systemName: "face.smiling")
        item.selectedImage = UIImage(systemName: "face.smiling.fill")
        
        return item
    }()
    
    lazy var addItem: UITabBarItem = {
        let item = UITabBarItem()
        item.title = "더보기"
        item.image = UIImage(systemName: "rectangle.grid.2x2")
        item.selectedImage = UIImage(systemName: "rectangle.grid.2x2.fill")
        
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        view.tintColor = .label
        
        let calendarViewController = MainNavigationView(rootViewController: MainViewController())
        calendarViewController.tabBarItem = calendarItem
        
        let endViewController = UINavigationController(rootViewController: UIViewController())
        endViewController.tabBarItem = endItem
        
        let starViewController = UINavigationController(rootViewController: UIViewController())
        starViewController.tabBarItem = starItem
        
        let smileViewController = UINavigationController(rootViewController: UIViewController())
        smileViewController.tabBarItem = smileItem
        
        let addViewController = UINavigationController(rootViewController: UIViewController())
        addViewController.tabBarItem = addItem
        
        viewControllers = [calendarViewController, endViewController, starViewController, smileViewController, addViewController]
        
        tabBarController?.selectedIndex = 0
    }


}

