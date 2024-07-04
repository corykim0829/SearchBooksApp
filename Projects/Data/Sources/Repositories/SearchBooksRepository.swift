//
//  SearchBooksRepository.swift
//  Data
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation
import Domain

public protocol SearchBooksRepository {
  func fetchBooks(keyword: String, page: Int) async throws -> SearchBooksResponse
}

public struct DefaultSearchBooksRepository: SearchBooksRepository {
  
  public init() { }
  
  public func fetchBooks(keyword: String, page: Int) async throws -> SearchBooksResponse {
    try await SearchBookAPI.shared.fetchBooks(searchKeyword: keyword, page: page)
  }
  
}
