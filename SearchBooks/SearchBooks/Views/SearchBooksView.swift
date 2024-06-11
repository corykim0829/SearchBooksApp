//
//  SearchBooksView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/10/24.
//

import SwiftUI

struct SearchBooksView: View {
  
  @State private var searchKeyword: String = ""
  
  var body: some View {
    NavigationView {
      List {
        Text("Hello, World!")
        Text("Hello, World!")
        Text("Hello, World!")
        Text("Hello, World!")
        Text("Hello, World!")
      }
      .listStyle(.plain)
      .navigationTitle("IT 책 검색")
    }
    .searchable(
      text: $searchKeyword,
      placement: .navigationBarDrawer,
      prompt: "책을 검색해보세요")
    
  }
}

#Preview {
  SearchBooksView()
}
