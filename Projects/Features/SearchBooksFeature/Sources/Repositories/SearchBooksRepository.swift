//
//  SearchBooksRepository.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import Foundation
import Domain

protocol SearchBooksRepositoryProtocol {
  func fetchBooks(keyword: String, page: Int) async throws -> SearchBooksResponse
}

struct SearchBooksRepository: SearchBooksRepositoryProtocol {
  
  func fetchBooks(keyword: String, page: Int) async throws -> SearchBooksResponse {
    try await SearchBookAPI.shared.fetchBooks(searchKeyword: keyword, page: page)
  }
  
}
