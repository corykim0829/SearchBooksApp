//
//  BookItemView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import SwiftUI
import Domain

struct BookItemView: View {
  
  var book: Book
  
  var body: some View {
    HStack(alignment: .top, spacing: 4) {
      ZStack(alignment: .bottomLeading) {
        ImageView(urlString: book.image)
          .frame(width: 100, height: 120)
        Button {
          NotificationCenter.default.post(
            name: .bookItemViewBookmarkButtonDidTap,
            object: nil,
            userInfo: ["book": book])
        } label: {
          if book.isSaved {
            Image(systemName: "bookmark.fill")
              .tint(Color.black)
          } else {
            Image(systemName: "bookmark")
              .tint(Color.black)
          }
        }
        .padding(.leading, 4)
        .padding(.bottom, 4)
      }
      
      VStack(alignment: .leading) {
        VStack(alignment: .leading, spacing: 2) {
          Text(book.title)
            .font(.system(size: 20, weight: .semibold))
            .frame(maxHeight: 28)
          Text(book.subtitle)
            .font(.system(size: 16, weight: .regular))
            .frame(maxHeight: 48)
        }
        Text(book.price)
          
      }
    }
    .padding(.trailing, 20)

  }
  
}

extension NSNotification.Name {
  static let bookItemViewBookmarkButtonDidTap = NSNotification.Name("bookItemViewBookmarkButtonDidTap")
}

struct BookItemView_Preview: PreviewProvider {
  
  static let sampleBook = Book(title: "책 제목입니다.", subtitle: "책에대한 설명입니다", isbn13: "", price: "$20", image: "", isSaved: true)
  
  static var previews: some View {
    BookItemView(book: sampleBook)
  }
  
}
