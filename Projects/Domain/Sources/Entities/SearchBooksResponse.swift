//
//  SearchBooksResponse.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation

public struct SearchBooksResponse: Decodable {
  public let error: String
  public let total: String
  public let page: String
  public let books: [RemoteBookEntity]
}
