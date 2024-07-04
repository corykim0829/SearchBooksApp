//
//  BookmarkBook.swift
//  Domain
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation

public struct BookmarkBook {
  public let title: String
  public let subtitle: String
  public let isbn13: String
  public let price: String
  public let image: String
  public let savedAt: Date
  
  public init(title: String, subtitle: String, isbn13: String, price: String, image: String, savedAt: Date) {
    self.title = title
    self.subtitle = subtitle
    self.isbn13 = isbn13
    self.price = price
    self.image = image
    self.savedAt = savedAt
  }
}
