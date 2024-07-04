//
//  SearchBookAPI.swift
//  Data
//
//  Created by Cory Kim on 7/4/24.
//

import Foundation
import Domain

enum SearchBookAPIError: Error {
  case badURL
  case wrongResponse
  case decodingError
}

class SearchBookAPI {
  
  static let shared = SearchBookAPI()
  
  let hostURL = "https://api.itbook.store/1.0"
  
  func fetchBooks(searchKeyword: String, page: Int = 1) async throws -> SearchBooksResponse {
    
    
    guard let url = URL(string: "\(hostURL)/search/\(searchKeyword)/\(page)") else {
      throw SearchBookAPIError.badURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse,
          response.statusCode == 200 else {
      throw SearchBookAPIError.wrongResponse
    }
    
    do {
      let searchBooksResponse = try JSONDecoder().decode(SearchBooksResponse.self, from: data)
      return searchBooksResponse
    } catch {
      throw SearchBookAPIError.decodingError
    }
    
  }
  
  func fetchDetail(id: String) async throws -> RemoteBookDetailEntity {
    
    guard let url = URL(string: "\(hostURL)/books/\(id)") else {
      throw SearchBookAPIError.badURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse,
          response.statusCode == 200 else {
      throw SearchBookAPIError.wrongResponse
    }
    
    do {
      let detailData = try JSONDecoder().decode(RemoteBookDetailEntity.self, from: data)
      return detailData
    } catch {
      throw SearchBookAPIError.decodingError
    }
    
  }
  
}
