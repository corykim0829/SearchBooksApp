//
//  BookDetailViewModel.swift
//  DesignKit
//
//  Created by Cory Kim on 7/4/24.
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
    bookDetailRepository: BookDetailRepository = DefaultBookDetailRepository(),
    savedBookRepository: SavedBookRepository = DefaultSavedBookRepository()) {
      self.bookDetailRepository = bookDetailRepository
      self.savedBookRepository = savedBookRepository
      self.fetchDetailData(id: book.isbn13)
    }
  
  func toggleSavedBook(bookDetail: BookDetail) {
    if bookDetail.isSaved {
      savedBookRepository.deleteBook(bookISBN13: bookDetail.isbn13)
    } else {
      savedBookRepository.saveBook(bookDetail: bookDetail)
    }
    
    guard let detailData = detailData else { return }
    let isSaved = savedBookRepository.fetchSavedBook(byISBN13: bookDetail.isbn13) != nil
    self.detailData = BookDetail(
      title: detailData.title,
      subtitle: detailData.subtitle,
      authors: detailData.authors,
      publisher: detailData.publisher,
      isbn13: detailData.isbn13,
      desc: detailData.desc,
      price: detailData.price,
      image: detailData.image,
      isSaved: isSaved,
      pdf: detailData.pdf)
    
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
