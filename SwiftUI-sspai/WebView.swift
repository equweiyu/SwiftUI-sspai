//
//  WebView.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/7/31.
//  Copyright © 2020 bai. All rights reserved.
//
import Combine
import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    let urlString: String
    
    @Binding var estimatedProgress: Double
    fileprivate let wkWebView = WKWebView()
    
    init(urlString: String, estimatedProgress: Binding<Double> = .constant(0)) {
        self.urlString = urlString
        _estimatedProgress = estimatedProgress
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        if let url = URL(string: self.urlString) {
            let requeset = URLRequest(url: url)
            wkWebView.navigationDelegate = context.coordinator
            wkWebView.uiDelegate = context.coordinator
            wkWebView.isOpaque = false
            wkWebView.load(requeset)
            wkWebView
                .publisher(for: \.estimatedProgress, options: .new)
                .sink(receiveValue: { self.estimatedProgress = $0})
                .store(in: &context.coordinator.cancellableSet)
        }
        return wkWebView
        
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView
        var cancellableSet: Set<AnyCancellable> = []
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
        WebView(urlString: "https://sspai.com/post/61928")
    }
}
