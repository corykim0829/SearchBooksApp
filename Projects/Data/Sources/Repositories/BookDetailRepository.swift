//
//  BookDetailRepository.swift
//  Data
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation
import Domain

public protocol BookDetailRepository {
  func fetchBookDetail(id: String) async throws -> RemoteBookDetailEntity
}

public struct DefaultBookDetailRepository: BookDetailRepository {
  
  public init() { }
  
  public func fetchBookDetail(id: String) async throws -> RemoteBookDetailEntity {
    try await SearchBookAPI.shared.fetchDetail(id: id)
  }
  
}
