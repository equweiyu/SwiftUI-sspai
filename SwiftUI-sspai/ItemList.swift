//
//  ItemList.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI

struct ItemList: View {
    @State var items: [ItemBean] = []
    var body: some View {
        NavigationView {
            List(0 ..< self.items.count, id: \.self) { index in
                ZStack {

                    ItemCell(item: self.items[index])
                        .onAppear {
                            self.fetchMoreItemsIfNeed(current: index)
                    }
                    NavigationLink(destination: WebView(urlString: "https://sspai.com/post/\(self.items[index].id)" ).navigationBarTitle("", displayMode: .inline)
                        .edgesIgnoringSafeArea(Edge.Set.all)
                    ) {
                        EmptyView()
                    }

                }
            }.onAppear {
                self.fetchItemList()
            }
            .navigationBarTitle("sspai")
            .navigationBarItems(trailing: Button(action: {
                self.fetchItemList()
            }, label: {
                Text("刷新")
            }))
        }
    }

    func fetchItemList() {
        let url = URL(string: "https://sspai.com/api/v1/article/index/page/get")!
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                // Error
                return
            }
            guard let items = try? JSONDecoder().decode(NetworkResponse<[ItemBean]>.self, from: data).data else {
                // Error
                return
            }
            DispatchQueue.main.async {
                self.items = items
            }
        }.resume()
    }

    func fetchMoreItemsIfNeed(current: Int) {
        guard current == self.items.count - 1 else {
            return
        }
        let url = URL(string: "https://sspai.com/api/v1/article/index/page/get?limit=10&offset=\(items.count)")!

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data else {
                    // Error
                    return
                }
                guard let items = try? JSONDecoder().decode(NetworkResponse<[ItemBean]>.self, from: data).data else {
                    // Error
                    return
                }
                self.items.append(contentsOf: items)
            }

        }.resume()
    }
}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList()
    }
}
