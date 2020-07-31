//
//  ItemCell.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    let item: ItemBean
    var body: some View {
        VStack {
            GeometryReader { geometry in
                NetWorkImage(url: URL(string: "https://cdn.sspai.com/\(self.item.banner)")!)
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

struct NetWorkImage: View {
    init(url: URL) {
        self.imageLoader = Loader(url)
    }

    @ObservedObject private var imageLoader: Loader
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        VStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
            } else {
                EmptyView()
            }
        }
    }

}

final class Loader: ObservableObject {

    var task: URLSessionDataTask!
    @Published var data: Data?

    init(_ url: URL) {
        task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            DispatchQueue.main.async {
                self.data = data
            }
        })
        task.resume()
    }
    deinit {
        task.cancel()
    }
}
