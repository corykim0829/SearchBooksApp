//
//  SearchBooksRepository.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import Foundation

struct SearchBooksRepository {
  
  func fetchBooks(keyword: String, page: Int) async throws -> SearchBooksResponse {
    try await SearchBookAPI.shared.fetchBooks(searchKeyword: keyword, page: page)
  }
  
}
