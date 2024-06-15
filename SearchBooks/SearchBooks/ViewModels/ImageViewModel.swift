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
    fetchImage(urlString: urlString)
  }
  
  private func fetchImage(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    Task {
      do {
        let (data, _) = try await URLSession.shared.data(from: url)
        image = UIImage(data: data)
      } catch {
        image = nil
      }
    }
    
  }
  
}
