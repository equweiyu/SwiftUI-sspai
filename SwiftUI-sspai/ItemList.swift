//
//  ItemList.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI
import Combine

struct ItemList: View {

    @ObservedObject var viewModel = ItemListViewModel()

    var body: some View {
        NavigationView {
            List(0 ..< self.viewModel.items.count, id: \.self) { index in
                ZStack {
                    ItemCell(item: self.viewModel.items[index])
                        .onAppear {
                            self.viewModel.fetchItemListMoreIfNeedPublisher.send(index)
                    }
                    NavigationLink(destination: WebView(urlString: "https://sspai.com/post/\(self.viewModel.items[index].id)" ).navigationBarTitle("", displayMode: .inline)
                        .edgesIgnoringSafeArea(Edge.Set.all)
                    ) {
                        EmptyView()
                    }
                }
            }
            .onAppear {
                self.viewModel.fetchItemListNewPublisher.send({}())
            }
            .navigationBarTitle("sspai")
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.fetchItemListNewPublisher.send(())
            }, label: {
                Text("刷新")
            }))
        }
    }

}

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList()
    }
}

class ItemListViewModel: ObservableObject {
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var items: [ItemBean] = []
    let fetchItemListNewPublisher = PassthroughSubject<Void, Never>()
    let fetchItemListMoreIfNeedPublisher = PassthroughSubject<Int, Never>()

    private let fetchItemList = { (url: URL) in
        URLSession.shared.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .map({ $0.data })
            .decode(type: NetworkResponse<[ItemBean]>.self, decoder: JSONDecoder())
            .map({ $0.data })
    }

    init() {

        fetchItemListNewPublisher
            .map({ URL(string: "https://sspai.com/api/v1/article/index/page/get")! })
            .setFailureType(to: Error.self)
            .flatMap(maxPublishers: .max(1), fetchItemList)
            .replaceError(with: [])
            .assign(to: \.items, on: self).store(in: &cancellableSet)

        fetchItemListMoreIfNeedPublisher
            .filter({ $0 == self.items.count - 1 })
            .map({ _ in URL(string: "https://sspai.com/api/v1/article/index/page/get?limit=10&offset=\(self.items.count)")! })
            .setFailureType(to: Error.self)
            .flatMap(maxPublishers: .max(1), fetchItemList)
            .replaceError(with: [])
            .map({ self.items + $0 })
            .assign(to: \.items, on: self).store(in: &cancellableSet)
    }
}
