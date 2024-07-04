//
//  ImageCacheManager.swift
//  DesignKit
//
//  Created by Cory Kim on 7/4/24.
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
