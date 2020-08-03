//
//  ItemCell.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ItemCell: View {
    let item: ItemBean
    var body: some View {
        VStack {
            GeometryReader { geometry in
                KFImage(URL(string: "https://cdn.sspai.com/\(self.item.banner)"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.width/2)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .aspectRatio(2, contentMode: .fit)
            .clipped()
            Text(item.title)
                .font(.headline)
            Spacer()
                .frame(height: 8)
            Text(item.summary)
                .font(.subheadline)
                .foregroundColor(Color.secondary)
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: ItemBean.mockData())
    }
}
