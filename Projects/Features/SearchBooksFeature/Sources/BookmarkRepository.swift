//
//  BookmarkRepository.swift
//  SearchBooksApp
//
//  Created by Cory Kim on 7/3/24.
//

import Foundation
import CoreData

public class BookmarkRepository {
  
  // MARK: - Core Data stack
  
  init() {
    fetchAllBookmarks()
  }

    // 컨테이너
    lazy var persistentContainer: NSPersistentContainer = {
        // 디비이름
        let container = NSPersistentContainer(name: "BookmarkDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
      
  var context : NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func addBookmark(isbn13: String) {
    let bookmarkEntity = BookmarkEntity(context: context)
    bookmarkEntity.isbn13 = isbn13
    context.insert(bookmarkEntity)
    
    do {
      try context.save()
    } catch {
      print(error)
    }
    
  }
  
  public func fetchAllBookmarks() -> [BookmarkEntity] {
    let bookmarkEntities = try? context.fetch(BookmarkEntity.fetchRequest()) as [BookmarkEntity]
    return bookmarkEntities ?? []
  }
  
  public func fetchBookmark(isbn13: String) -> BookmarkEntity? {
    // SELECT ALL
    let request = BookmarkEntity.fetchRequest()
    
    // WHERE
    request.predicate = BookmarkEntity.searchISBNPredicate.withSubstitutionVariables(["isbn13": isbn13])
    
    let bookmarkEntities = try? context.fetch(request) as [BookmarkEntity]
    guard let bookmarkEntity = bookmarkEntities?.first else {
      return nil
    }
    return bookmarkEntity
  }
  
  public func removeBookmark(isbn13: String) {
    if let bookmarkEntity = fetchBookmark(isbn13: isbn13) {
      context.delete(bookmarkEntity)
      do {
        try context.save()
      } catch {
        print(error)
      }
    }
    
  }
  
  public func removeAllBookmarks() {
    try? context.execute(BookmarkEntity.deleteAllRequest())
  }
  
}
