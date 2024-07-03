//
//  SavedBookRepository.swift
//  Data
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation
import RealmSwift
import Domain

public protocol SavedBookRepository {
  func fetchAllSavedBooks() -> Results<SavedBook>
  func fetchSavedBook(byISBN13: String) -> SavedBook?
  func saveBook(book: Book)
  func deleteBook(book: Book)
}

public class DefaultSavedBookRepository: SavedBookRepository {
  
  let realm = try! Realm()
  
  public init() { }
  
  public func fetchAllSavedBooks() -> Results<SavedBook> {
    let results = realm.objects(SavedBook.self)
    return results
  }
  
  public func fetchSavedBook(byISBN13 isbn13: String) -> SavedBook? {
    let savedBook = realm.objects(SavedBook.self)
      .filter {
        $0.isbn13 == isbn13
      }
      .first
    return savedBook
  }
  
  public func saveBook(book: Book) {
    let savedBook = SavedBook()
    savedBook.isbn13 = book.isbn13
    savedBook.title = book.title
    savedBook.subtitle = book.subtitle
    savedBook.price = book.price
    savedBook.image = book.image
    savedBook.savedAt = Date()
    
    try! realm.write {
      realm.add(savedBook)
    }
  }
  
  public func deleteBook(book: Book) {
    let book = realm.objects(SavedBook.self)
      .where {
        $0.isbn13 == book.isbn13
      }
    
    do {
      try realm.write {
        realm.delete(book)
      }
    } catch {
      print("Error deleting saved book: \(error)")
    }
  }
  
}
