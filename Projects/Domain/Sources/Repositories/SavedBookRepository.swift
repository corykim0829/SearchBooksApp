//
//  SavedBookRepository.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation
import Realm

protocol SavedBookRepository {
  func fetchAllBooks()
  func saveBook()
  func deleteBook()
}
