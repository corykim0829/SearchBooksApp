//
//  SearchBooksViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import UIKit
import Combine
import Data
import Domain

@MainActor
class SearchBooksViewModel: NSObject, ObservableObject {
  
  @Published var searchKeyword = ""
  
  var response: SearchBooksResponse? = nil
  @Published var books: [Book]? = nil
  
  @Published var isFetchingNextPage = false
  @Published var hasNoNextPage = false
  
  var searchCancellable: AnyCancellable? = nil
  
  let searchBooksRepository: SearchBooksRepository
  
  let savedBookRepository: SavedBookRepository
  
  init(
    searchBooksRepository: SearchBooksRepository = DefaultSearchBooksRepository(),
    savedBookRepository: SavedBookRepository = DefaultSavedBookRepository()) {
      self.searchBooksRepository = searchBooksRepository
      self.savedBookRepository = savedBookRepository
      super.init()
      
      searchCancellable = $searchKeyword
        .removeDuplicates()
        .debounce(for: 0.6, scheduler: RunLoop.main)
        .sink(receiveValue: { string in
          if string == "" {
            self.books = nil
          } else {
            self.searchBooks(keyword: string)
          }
        })
    }
  
  func toggleSavedBook(book: Book) {
    if book.isSaved {
      savedBookRepository.deleteBook(bookISBN13: book.isbn13)
    } else {
      savedBookRepository.saveBook(book: book)
    }
    
    // UPDATE Books
    guard let books = books else {
      return
    }
    let newBooks = books.map {
      if $0.isbn13 == book.isbn13 {
        let isSaved = savedBookRepository.fetchSavedBook(byISBN13: book.isbn13) != nil
        return Book(
          title: $0.title,
          subtitle: $0.subtitle,
          isbn13: $0.isbn13,
          price: $0.price,
          image: $0.image,
          isSaved: isSaved)
      } else {
        return $0
      }
    }
    
    self.books = newBooks
  }
  
  func updateSavedBook() {
    guard let books = books else {
      return
    }
    let newBooks = books.map {
      let isSaved = savedBookRepository.fetchSavedBook(byISBN13: $0.isbn13) != nil
      return Book(
        title: $0.title,
        subtitle: $0.subtitle,
        isbn13: $0.isbn13,
        price: $0.price,
        image: $0.image,
        isSaved: isSaved)
    }
    
    self.books = newBooks
  }
  
  func searchBooks(keyword: String) {
    Task {
      let searchResponse = try await searchBooksRepository.fetchBooks(keyword: searchKeyword, page: 1)
      response = searchResponse

      books = searchResponse.books.map {
        let isSaved = savedBookRepository.fetchSavedBook(byISBN13: $0.isbn13) != nil
        return Book(
          title: $0.title,
          subtitle: $0.subtitle,
          isbn13: $0.isbn13,
          price: $0.price,
          image: $0.image,
          isSaved: isSaved)
      }
    }
  }
  
  func fetchNextPage() {
    guard !isFetchingNextPage else {
      return
    }
    guard hasNextPage() else {
      hasNoNextPage = true
      return
    }
    guard let response = response else { return }
    isFetchingNextPage = true
    hasNoNextPage = false
    let currentPage = Int(response.page) ?? 1
    
    Task {
      try await Task.sleep(nanoseconds: UInt64(1 * 1_000_000_000))
      let searchResponse = try await searchBooksRepository.fetchBooks(keyword: searchKeyword, page: currentPage + 1)
      self.response = searchResponse
      isFetchingNextPage = false
      let nextPageBooks = searchResponse.books.map {
        let isSaved = savedBookRepository.fetchSavedBook(byISBN13: $0.isbn13) != nil
        return Book(
          title: $0.title,
          subtitle: $0.subtitle,
          isbn13: $0.isbn13,
          price: $0.price,
          image: $0.image,
          isSaved: isSaved)
      }
      books?.append(contentsOf: nextPageBooks)
    }
    
  }
  
  func hasNextPage() -> Bool {
    guard let totalStr = response?.total, let total = Int(totalStr),
            let pageStr = response?.page, let page = Int(pageStr) else {
      return false
    }
    
    let perPage = 10
    return page * perPage < total
  }
  
}

extension SearchBooksViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
      DispatchQueue.main.async {
        self.fetchNextPage()
      }
      
    }
    
  }
  
}
