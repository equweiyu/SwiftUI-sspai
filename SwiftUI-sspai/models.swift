//
//  models.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//

import Foundation
struct NetworkResponse<T: Codable> : Codable {
    let msg: String
    let error: Int
    let data: T
}
struct ItemBean: Codable, Identifiable {
    let id: Int
    let title: String
    let summary: String
    let banner: String
    
    static func mockData() -> ItemBean {
        return ItemBean(id: 1,
                        title: "为什么 ARM 版 Mac 运行效率很高？",
                        summary: "Matrix 精选Matrix 是少数派的写作社区，我们主张分享真实的产品体验，有实用价值的经验与思考。我们会不定期挑选 Matrix 最优质的文章，展示来自用户的最真实的体验和观点。文章代表作者个人...",
                        banner: "article/17fa0d60-e33a-abb0-09b0-d24e15f61e5f.jpg")
    }
}
