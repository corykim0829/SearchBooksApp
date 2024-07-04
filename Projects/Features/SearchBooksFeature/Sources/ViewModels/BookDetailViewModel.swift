//
//  BookDetailViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/13/24.
//

import Foundation
import Domain
import Data

@MainActor
class BookDetailViewModel: ObservableObject {
  
  @Published var detailData: BookDetail?
  let bookDetailRepository: BookDetailRepository
  let savedBookRepository: SavedBookRepository
  
  init(
    book: Book,
    bookDetailRepository: BookDetailRepository = BookDetailRepository(),
    savedBookRepository: SavedBookRepository = DefaultSavedBookRepository()) {
      self.bookDetailRepository = bookDetailRepository
      self.savedBookRepository = savedBookRepository
      self.fetchDetailData(id: book.isbn13)
    }
  
  private func fetchDetailData(id: String) {
    Task {
      do {
        let remoteDetailData = try await bookDetailRepository.fetchBookDetail(id: id)
        let isSaved = savedBookRepository.fetchSavedBook(byISBN13: id) != nil
        self.detailData = BookDetail(
          title: remoteDetailData.title,
          subtitle: remoteDetailData.subtitle,
          authors: remoteDetailData.authors,
          publisher: remoteDetailData.publisher,
          isbn13: remoteDetailData.isbn13,
          desc: remoteDetailData.desc,
          price: remoteDetailData.price,
          image: remoteDetailData.image,
          isSaved: isSaved,
          pdf: remoteDetailData.pdf)
      } catch {
        print("book detail fetch error:", error)
      }
      
    }
  }
  
}
