//
//  WKWebViewRepresentableView.swift
//  DesignKit
//
//  Created by Cory Kim on 7/4/24.
//

import SwiftUI
import WebKit

struct WKWebViewRepresentableView: UIViewRepresentable {
  
  var url: String
  
  func makeUIView(context: Context) -> WKWebView {
    guard let url = URL(string: url) else {
      return WKWebView()
    }
    let webView = WKWebView()
    webView.load(URLRequest(url: url))
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    // update
  }
  
}

