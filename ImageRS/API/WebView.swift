//
//  WebView.swift
//  Pokedex2.0
//
//  Created by Karthik Manishankar on 7/30/22.
//

import SwiftUI
import Foundation
import WebKit


struct WebView: UIViewRepresentable {
        
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

