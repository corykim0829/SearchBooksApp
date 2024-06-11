//
//  BookItemView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import SwiftUI

struct BookItemView: View {
  
  @Binding var book: Book
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Rectangle()
        .fill(.yellow)
        .frame(width: 80, height: 100)
      VStack(alignment: .leading) {
        Text(book.title)
          .font(.system(size: 20, weight: .semibold))
        Text(book.subtitle)
        Text(book.price)
          
      }
    }

  }
  
}

struct BookItemView_Preview: PreviewProvider {
  
  static let sampleBook = Book(title: "책 제목입니다.", subtitle: "책에대한 설명입니다", isbn13: "", price: "$20", image: "", url: "")
  
  static var previews: some View {
    BookItemView(book: .constant(sampleBook))
  }
  
}
