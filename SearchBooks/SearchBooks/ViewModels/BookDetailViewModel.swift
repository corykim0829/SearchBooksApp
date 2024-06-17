//
//  BookDetailViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/13/24.
//

import Foundation

@MainActor
class BookDetailViewModel: ObservableObject {
  
  @Published var detailData: BookDetail?
  
  init(book: Book) {
    self.fetchDetailData(id: book.isbn13)
  }
  
  func fetchDetailData(id: String) {
    let repo = BookDetailRepository()
    Task {
      do {
        detailData = try await repo.fetchBookDetail(id: id)
      } catch {
        print("book detail fetch error:", error)
      }
      
    }
  }
  
}
