//
//  BookItemView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import SwiftUI

struct BookItemView: View {
  
  var book: Book
  
  var body: some View {
    HStack(alignment: .top, spacing: 4) {
      ZStack(alignment: .bottomLeading) {
        ImageView(urlString: book.image)
          .frame(width: 100, height: 120)
        Button(action: {
//          print(book.isbn13)
          NotificationCenter.default.post(
            name: .bookItemViewBookmarkTappedNotification,
            object: book,
            userInfo: ["isbn": book.isbn13])
        }, label: {
          Image(systemName: "star")
        })
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
  static let bookItemViewBookmarkTappedNotification = NSNotification.Name("bookItemViewBookmarkTappedNotification")
}

struct BookItemView_Preview: PreviewProvider {
  
  static let sampleBook = Book(title: "책 제목입니다.", subtitle: "책에대한 설명입니다", isbn13: "", price: "$20", image: "", url: "")
  
  static var previews: some View {
    BookItemView(book: sampleBook)
  }
  
}
