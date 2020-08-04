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
    private let wkWebView = WKWebView()
    
    func makeUIView(context: Context) -> UIView {
        
        if let url = URL(string: self.urlString) {
            let requeset = URLRequest(url: url)
            wkWebView.navigationDelegate = context.coordinator
            wkWebView.uiDelegate = context.coordinator
            wkWebView.isOpaque = false
            wkWebView.load(requeset)
        }
        return wkWebView
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            decisionHandler(.allow)
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "urlString")
    }
}
