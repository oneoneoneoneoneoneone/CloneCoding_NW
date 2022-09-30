//
//  Content.swift
//  NaverWebtoon
//
//  Created by hana on 2022/09/13.
//

import Foundation

struct CalendarContent: Decodable{
    let sectionType: SectionType
    let contentItem: [Item]

}

enum SectionType: String, Decodable{
    case banner, basic, ai, rank, update
    
    var identifier: String{
        switch self {
        case .banner:
            return "StickyHeaderViewCell"
        case .basic:
            return "CalendarBasicViewCell"
        case .ai:
            return "CalendarAiViewCell"
        case .rank:
            return "CalendarRankViewCell"
        case .update:
            return "CalendarUpdateViewCell"
        }
    }
}

struct Item: Decodable{
    let title: String
    let description: String
    let imageName: String
    let writer: String
    let updateDay: String
    let score: Double
    let isUpdate: Bool
    let isStop: Bool
    let isIncrease: Bool
    
}
