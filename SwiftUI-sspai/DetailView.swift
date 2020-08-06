//
//  DetailView.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/8/6.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let item: ItemBean
    
    @State var estimatedProgress: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            if self.estimatedProgress < 1 {
                ProgressView(progress: Float(self.estimatedProgress))
            } else {
                EmptyView()
            }
            WebView(
                urlString: "https://sspai.com/post/\(self.item.id)",
                estimatedProgress: self.$estimatedProgress
            )
        }
        .navigationBarTitle("", displayMode: .inline)
        .edgesIgnoringSafeArea(Edge.Set.bottom)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(item: ItemBean.mockData())
        }
    }
}
