//
//  BookDetail.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/13/24.
//

import Foundation

struct BookDetail: Decodable {
  let title, subtitle, authors, publisher: String
  let isbn10, isbn13: String
  let pages, year, rating: String
  let desc, price: String
  let image: String
  let pdf: [String: String]?
}
