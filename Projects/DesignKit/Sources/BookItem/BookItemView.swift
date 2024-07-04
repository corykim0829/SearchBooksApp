//
//  BookItemView.swift
//  DesignKit
//
//  Created by Cory Kim on 7/4/24.
//

import SwiftUI
import Domain

public struct BookItemView: View {
  
  var book: Book
  
  var bookmarkButtonAction: (Book) -> Void
  
  public init(book: Book, bookmarkButtonAction: @escaping (Book) -> Void) {
    self.book = book
    self.bookmarkButtonAction = bookmarkButtonAction
  }
  
  public var body: some View {
    HStack(alignment: .top, spacing: 4) {
      ZStack(alignment: .bottomLeading) {
        ImageView(urlString: book.image)
          .frame(width: 100, height: 120)
        Button {
          bookmarkButtonAction(book)
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

struct BookItemView_Preview: PreviewProvider {
  
  static let sampleBook = Book(title: "책 제목입니다.", subtitle: "책에대한 설명입니다", isbn13: "", price: "$20", image: "", isSaved: true)
  
  static var previews: some View {
    BookItemView(book: sampleBook, bookmarkButtonAction: { _ in })
  }
  
}
