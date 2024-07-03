//
//  SavedBook.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation
import RealmSwift

public class SavedBook: Object {
  @Persisted(primaryKey: true) var id: String
  @Persisted var title: String
  @Persisted var subtitle: String
  @Persisted var price: String
  @Persisted var image: String
  @Persisted var savedAt: Date
}
