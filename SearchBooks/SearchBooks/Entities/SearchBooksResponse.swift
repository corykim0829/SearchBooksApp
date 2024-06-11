//
//  SearchBooksResponse.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import Foundation

struct SearchBooksResponse: Decodable {
  let error: String
  let total: String
  let page: String
  let books: [Book]
}
