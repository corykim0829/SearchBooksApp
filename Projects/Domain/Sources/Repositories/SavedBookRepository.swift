//
//  SavedBookRepository.swift
//  Domain
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation
import RealmSwift

protocol SavedBookRepository {
  func fetchAllSavedBooks() -> Results<SavedBook>
  func fetchSavedBook(byISBN13: String) -> SavedBook?
  func saveBook(remoteBookEntity: RemoteBookEntity)
  func deleteBook(remoteBookEntity: RemoteBookEntity)
}

public class DefaultSavedBookRepository: SavedBookRepository {
  
  let realm = try! Realm()
  
  func fetchAllSavedBooks() -> Results<SavedBook> {
    let results = realm.objects(SavedBook.self)
    return results
  }
  
  func fetchSavedBook(byISBN13 isbn13: String) -> SavedBook? {
    let savedBook = realm.objects(SavedBook.self)
      .filter {
        $0.isbn13 == isbn13
      }
      .first
    return savedBook
  }
  
  func saveBook(remoteBookEntity: RemoteBookEntity) {
    let book = SavedBook()
    book.isbn13 = remoteBookEntity.isbn13
    book.title = remoteBookEntity.title
    book.subtitle = remoteBookEntity.subtitle
    book.price = remoteBookEntity.price
    book.image = remoteBookEntity.image
    book.savedAt = Date()
    
    try! realm.write {
      realm.add(book)
    }
  }
  
  func deleteBook(remoteBookEntity: RemoteBookEntity) {
    let book = realm.objects(SavedBook.self)
      .where {
        $0.isbn13 == remoteBookEntity.isbn13
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
