//
//  WebView.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    let urlString: String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlString) else {
            return WKWebView()
        }
        let requeset = URLRequest(url: url)
        let wk = WKWebView()
        wk.isOpaque = false
        wk.load(requeset)
        return wk
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "urlString")
    }
}
