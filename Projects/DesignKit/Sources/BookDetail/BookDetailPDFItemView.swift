//
//  BookDetailPDFItemView.swift
//  DesignKit
//
//  Created by Cory Kim on 7/4/24.
//

import SwiftUI

struct BookDetailPDFItemView: View {
  
  let title: String
  let url: String
  
  @Binding var isShowingPDFWebView: Bool
  
  var body: some View {
    HStack {
      Text(title)
        .lineLimit(1)
        .font(.system(size: 14, weight: .regular))
      Spacer()
        .frame(width: 16)
      Button(self.url) {
        isShowingPDFWebView = true
      }
      .lineLimit(1)
      .font(.system(size: 14, weight: .regular))
      Spacer()
    }
  }
}

#Preview {
  BookDetailPDFItemView(title: "Chapter1", url: "https://itbook.store/files/9781617294136/chapter5.pdf", isShowingPDFWebView: .constant(false))
}
