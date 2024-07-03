//
//  BookDetailViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/13/24.
//

import Foundation
import Domain

@MainActor
class BookDetailViewModel: ObservableObject {
  
  @Published var detailData: BookDetail?
  let bookDetailRepository: BookDetailRepository
  
  init(book: RemoteBookEntity, repository: BookDetailRepository = BookDetailRepository()) {
    self.bookDetailRepository = repository
    self.fetchDetailData(id: book.isbn13)
  }
  
  private func fetchDetailData(id: String) {
    Task {
      do {
        detailData = try await bookDetailRepository.fetchBookDetail(id: id)
      } catch {
        print("book detail fetch error:", error)
      }
      
    }
  }
  
}
