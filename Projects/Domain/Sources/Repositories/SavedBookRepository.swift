//
//  SavedBookRepository.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation
import RealmSwift

protocol SavedBookRepository {
  func fetchAllBooks()
  func saveBook()
  func deleteBook()
}

public class DefaultSavedBookRepository: SavedBookRepository {
  func fetchAllBooks() {
    let realm = try! Realm()

  }
  
  func saveBook() {
    
  }
  
  func deleteBook() {
    
  }
  
  
}
