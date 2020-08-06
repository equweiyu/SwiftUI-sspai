//
//  ProgressView.swift
//  SwiftUI-sspai
//
//  Created by Bai1992 on 2020/8/6.
//  Copyright © 2020 bai. All rights reserved.
//

import SwiftUI

struct ProgressView: UIViewRepresentable {
    
    let progress: Float
    func makeUIView(context: Context) -> UIProgressView {
        let progressView = UIProgressView()
        progressView.progress = self.progress
        return progressView
    }
    func updateUIView(_ uiView: UIProgressView, context: Context) {
        uiView.progress = self.progress
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progress: 0.5)
    }
}
