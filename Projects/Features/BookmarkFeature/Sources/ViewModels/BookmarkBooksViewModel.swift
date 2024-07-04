//
//  BookmarkBooksViewModel.swift
//  BookmarkFeature
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation
import Data
import Domain

class BookmarkBooksViewModel: ObservableObject {
  
  enum Sorting: CaseIterable {
    case latest
    case oldest
    
    var title: String {
      switch self {
      case .latest:
        return "최신순"
      case .oldest:
        return "오래된순"
      }
    }
  }
  
  @Published var books: [BookmarkBook] = []
  
  let savedBookRepository: SavedBookRepository
  
  var currentSorting: Sorting = .latest
  
  init(savedBookRepository: SavedBookRepository = DefaultSavedBookRepository()) {
    self.savedBookRepository = savedBookRepository
    fetchAllBooks()
  }
  
  func fetchAllBooks() {
    books = Array(savedBookRepository.fetchAllSavedBooks()).map {
      BookmarkBook(
        title: $0.title,
        subtitle: $0.subtitle,
        isbn13: $0.isbn13,
        price: $0.price,
        image: $0.image,
        savedAt: $0.savedAt)
    }.sorted {
      switch currentSorting {
      case .latest:
        return $0.savedAt > $1.savedAt
      case .oldest:
        return $0.savedAt < $1.savedAt
      }
    }
  }
  
}
