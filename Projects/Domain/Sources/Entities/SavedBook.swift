//
//  SavedBook.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation
import RealmSwift

public class SavedBook: Object {
  @Persisted(primaryKey: true) public var isbn13: String
  @Persisted public var title: String
  @Persisted public var subtitle: String
  @Persisted public var price: String
  @Persisted public var image: String
  @Persisted public var savedAt: Date
}
