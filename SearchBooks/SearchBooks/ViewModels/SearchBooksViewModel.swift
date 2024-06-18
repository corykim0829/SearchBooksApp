//
//  SearchBooksViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import Foundation
import Combine

@MainActor
class SearchBooksViewModel: ObservableObject {
  
  @Published var searchKeyword = ""
  
  var response: SearchBooksResponse? = nil
  @Published var fetchedBooks: [Book]? = nil
  
  @Published var isFetchingNextPage = false
  @Published var hasNoNextPage = false
  
  var searchCancellable: AnyCancellable? = nil
  
  let searchBooksRepository: SearchBooksRepository
  
  init(repository: SearchBooksRepository = SearchBooksRepository()) {
    self.searchBooksRepository = repository
    
    searchCancellable = $searchKeyword
      .removeDuplicates()
      .debounce(for: 0.6, scheduler: RunLoop.main)
      .sink(receiveValue: { string in
        if string == "" {
          self.fetchedBooks = nil
        } else {
          self.searchBooks(keyword: string)
        }
      })
  }
  
  func searchBooks(keyword: String) {
    Task {
      let searchResponse = try await searchBooksRepository.fetchBooks(keyword: searchKeyword, page: 1)
      response = searchResponse
      fetchedBooks = searchResponse.books
    }
  }
  
  func fetchNextPage() {
    guard !isFetchingNextPage else {
      isFetchingNextPage = false
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
    let repository = SearchBooksRepository()
    
    Task {
      let searchResponse = try await repository.fetchBooks(keyword: searchKeyword, page: currentPage + 1)
      self.response = searchResponse
      isFetchingNextPage = false
      fetchedBooks?.append(contentsOf: searchResponse.books)
    }
    
  }
  
  private func hasNextPage() -> Bool {
    guard let totalStr = response?.total, let total = Int(totalStr),
            let pageStr = response?.page, let page = Int(pageStr) else {
      return false
    }
    
    let perPage = 10
    return page * perPage < total
  }
  
}
