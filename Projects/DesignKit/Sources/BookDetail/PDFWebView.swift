//
//  PDFWebView.swift
//  DesignKit
//
//  Created by Cory Kim on 7/4/24.
//

import SwiftUI

struct PDFWebView: View {
  
  var url: String
  @Binding var isShowingPDFWebView: Bool
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button("닫기") {
          isShowingPDFWebView = false
        }
        Spacer()
          .frame(width: 16)
      }
      .frame(height: 48)
      WKWebViewRepresentableView(url: url)
    }
  }
}

#Preview {
  PDFWebView(
    url: "https://itbook.store/files/9781617294136/chapter5.pdf",
    isShowingPDFWebView: .constant(true))
}
