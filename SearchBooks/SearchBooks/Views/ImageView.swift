//
//  ImageView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/15/24.
//

import SwiftUI

struct ImageView: View {
  
  @ObservedObject var viewModel: ImageViewModel
  
  init(urlString: String) {
    viewModel = ImageViewModel(urlString: urlString)
  }
  
  var body: some View {
    Image(uiImage: viewModel.image ?? UIImage())
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
}

#Preview {
  ImageView(urlString: "https://developer.apple.com/news/images/og/swiftui-og.png")
}
