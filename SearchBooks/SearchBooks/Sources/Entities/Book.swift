//
//  Book.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/11/24.
//

import Foundation

struct Book: Decodable {
  let title: String
  let subtitle: String
  let isbn13: String
  let price: String
  let image: String
  let url: String
}
