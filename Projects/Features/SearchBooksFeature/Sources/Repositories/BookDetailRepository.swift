//
//  BookDetailRepository.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/13/24.
//

import Foundation
import Domain

struct BookDetailRepository {
  
  func fetchBookDetail(id: String) async throws -> RemoteBookDetailEntity {
    try await SearchBookAPI.shared.fetchDetail(id: id)
  }
  
}
