//
//  BookDetail.swift
//  Domain
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation

public struct BookDetail: Decodable {
  public let title, subtitle, authors, publisher: String
  public let isbn13: String
  public let desc, price: String
  public let image: String
  public let isSaved: Bool
  public let pdf: [String: String]?
  
  public init(title: String, subtitle: String, authors: String, publisher: String, isbn13: String, desc: String, price: String, image: String, isSaved: Bool, pdf: [String : String]?) {
    self.title = title
    self.subtitle = subtitle
    self.authors = authors
    self.publisher = publisher
    self.isbn13 = isbn13
    self.desc = desc
    self.price = price
    self.image = image
    self.isSaved = isSaved
    self.pdf = pdf
  }
}
