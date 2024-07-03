//
//  BookmarkEntity+CoreDataProperties.swift
//  SearchBooksApp
//
//  Created by Cory Kim on 7/3/24.
//
//

import Foundation
import CoreData


extension BookmarkEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookmarkEntity> {
        return NSFetchRequest<BookmarkEntity>(entityName: "BookmarkEntity")
    }
  
  @nonobjc public class func deleteAllRequest() -> NSBatchDeleteRequest {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BookmarkEntity")
    
    return NSBatchDeleteRequest(fetchRequest: request)
    
  }

    @NSManaged public var isbn13: String?

}

extension BookmarkEntity : Identifiable {
  
}


extension BookmarkEntity {
  static var searchISBNPredicate: NSPredicate {
    NSPredicate(format: "%K == $isbn13", #keyPath(isbn13))
  }
}
