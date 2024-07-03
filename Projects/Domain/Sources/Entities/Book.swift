//
//  Book.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation

public struct Book: Decodable {
  public let title: String
  public let subtitle: String
  public let isbn13: String
  public let price: String
  public let image: String
  public let url: String
  
  public init(title: String, subtitle: String, isbn13: String, price: String, image: String, url: String) {
    self.title = title
    self.subtitle = subtitle
    self.isbn13 = isbn13
    self.price = price
    self.image = image
    self.url = url
  }
}
