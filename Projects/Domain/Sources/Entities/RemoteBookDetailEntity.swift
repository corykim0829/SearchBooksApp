//
//  RemoteBookDetailEntity.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation

public struct RemoteBookDetailEntity: Decodable {
  public let title, subtitle, authors, publisher: String
  public let isbn10, isbn13: String
  public let pages, year, rating: String
  public let desc, price: String
  public let image: String
  public let pdf: [String: String]?
}
