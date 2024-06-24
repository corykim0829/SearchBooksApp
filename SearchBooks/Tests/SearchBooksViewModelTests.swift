//
//  SearchBooksViewModelTests.swift
//  SearchBooksTests
//
//  Created by Cory Kim on 6/23/24.
//

import XCTest
@testable import SearchBooks

final class SearchBooksViewModelTests: XCTestCase {
  
  var sut: SearchBooksViewModel!
  
  struct SearchBooksRepositorySpy: SearchBooksRepositoryProtocol {
    func fetchBooks(keyword: String, page: Int) async throws -> SearchBooks.SearchBooksResponse {
      try await Task.sleep(nanoseconds: 2_000_000_000)
      return SearchBooksResponse(error: "", total: "", page: "", books: [])
    }
    
  }
  
  @MainActor
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    sut = SearchBooksViewModel(repository: SearchBooksRepositorySpy())
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  @MainActor
  func testSearchBooks() throws {
    sut.searchBooks(keyword: "Swift")
    
    Task {
//      try await Task.sleep(nanoseconds: 2_000_000_000)
      XCTAssertNotNil(sut.response, "데이터가 없습니다.")
    }
  }
  
  @MainActor
  func testHasNextPageTrue() throws {
    sut.response = SearchBooksResponse(error: "", total: "48", page: "1", books: [])
    XCTAssertTrue(sut.hasNextPage())
  }
  
  @MainActor
  func testHasNextPageFalse() throws {
    sut.response = SearchBooksResponse(error: "", total: "18", page: "2", books: [])
    XCTAssertFalse(sut.hasNextPage())
  }
  
}
