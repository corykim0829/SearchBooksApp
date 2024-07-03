//
//  SearchBooksViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import UIKit
import Combine

@MainActor
class SearchBooksViewModel: NSObject, ObservableObject {
  
  @Published var searchKeyword = ""
  
  var response: SearchBooksResponse? = nil
  @Published var fetchedBooks: [Book]? = nil
  
  @Published var isFetchingNextPage = false
  @Published var hasNoNextPage = false
  
  var searchCancellable: AnyCancellable? = nil
  
  let searchBooksRepository: SearchBooksRepositoryProtocol
  
  let bookmarkRepository = BookmarkRepository()
  
  init(repository: SearchBooksRepositoryProtocol = SearchBooksRepository()) {
    self.searchBooksRepository = repository
    super.init()
    
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
  
  func addBookmark(isbn13: String) {
    bookmarkRepository.addBookmark(isbn13: isbn13)
    
    //print("bookmark DB", bookmarkRepository.fetchAllBookmarks())
  }
  
  func deleteBookmark(isbn13: String) {
    bookmarkRepository.removeBookmark(isbn13: isbn13)
  }
  
  func searchBooks(keyword: String) {
    Task {
      let searchResponse = try await searchBooksRepository.fetchBooks(keyword: searchKeyword, page: 1)
      response = searchResponse
      fetchedBooks = searchResponse.books
//      var remoteBooks = searchResponse.books
//      var localBooks = someFavoriteLocalRepo.books
      
      // id를 기준으로 합치기 -> 모델 또는 튜플
//      [(북, 좋아요 여부)]
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
      fetchedBooks?.append(contentsOf: searchResponse.books)
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
