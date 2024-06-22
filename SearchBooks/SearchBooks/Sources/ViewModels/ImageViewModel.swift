//
//  ImageViewModel.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/15/24.
//

import UIKit

@MainActor
class ImageViewModel: ObservableObject {
  
  @Published var image: UIImage?
  
  init(urlString: String) {
    loadImage(urlString: urlString)
  }
  
  private func loadImage(urlString: String) {
    if let imageFromCache = ImageCacheManager.shared.getImageFromCache(key: urlString) {
      self.image = imageFromCache
      return
    }
    fetchImageFromURL(urlString: urlString)
  }
  
  private func fetchImageFromURL(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    Task {
      do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
          self.image = image
          ImageCacheManager.shared.saveImageCache(key: urlString, image: image)
        }
      } catch {
        image = nil
      }
    }
    
  }
  
}
