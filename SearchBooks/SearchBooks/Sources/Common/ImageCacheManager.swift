//
//  ImageCacheManager.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/18/24.
//

import UIKit

final class ImageCacheManager {
  
  static let shared = ImageCacheManager()
  let imageCache = NSCache<NSString, UIImage>()
  
  private init() { }
  
  func saveImageCache(key: String, image: UIImage) {
    imageCache.setObject(image, forKey: key as NSString)
  }
  
  func getImageFromCache(key: String) -> UIImage? {
    return imageCache.object(forKey: key as NSString)
  }
  
}
