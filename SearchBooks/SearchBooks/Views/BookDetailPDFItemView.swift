//
//  BookDetailPDFItemView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/20/24.
//

import SwiftUI

struct BookDetailPDFItemView: View {
  
  let title: String
  let url: String
  
  var body: some View {
    HStack {
      Text(title)
        .lineLimit(1)
        .font(.system(size: 14, weight: .regular))
      Spacer()
        .frame(width: 16)
      if let url = URL(string: url) {
        Link(self.url, destination: url)
          .lineLimit(1)
          .font(.system(size: 14, weight: .regular))
      } else {
        Text(url)
          .lineLimit(1)
          .font(.system(size: 14, weight: .regular))
      }
      Spacer()
    }
  }
}

#Preview {
  BookDetailPDFItemView(title: "Chapter1", url: "https://itbook.store/files/9781617294136/chapter5.pdf")
}
