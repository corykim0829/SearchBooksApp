//
//  SearchBooksView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/10/24.
//

import SwiftUI

struct SearchBooksView: View {
  
  @StateObject var viewModel = SearchBooksViewModel()
  
  @State var fetchedBooks : [Book] = []
  
  var body: some View {
    
    NavigationView {
      
      ScrollView(.vertical) {
        
        VStack(spacing: 16) {
          HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
            TextField("책을 검색하세요", text: $viewModel.searchKeyword)
          }
          .padding(.vertical, 10)
          .padding(.horizontal)
          .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
          .shadow(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)
        }
        .padding(.vertical, 16)
        
        if let books = viewModel.fetchedBooks {
          
          if books.isEmpty {
            Text("결과가 없습니다.")
              .padding(.top, 20)
          } else {
            LazyVStack(alignment: .leading) {
              
              ForEach(books, id: \.isbn13) { book in
                NavigationLink {
                  BookDetailView(book: book)
                } label: {
                  BookItemView(book: book)
                }
                .buttonStyle(PlainButtonStyle())
              }
            }
            
            // 다음 페이지 값 로딩뷰 처리
            if viewModel.isFetchingNextPage {
              ProgressView()
            }
            
            if viewModel.hasNoNextPage {
              Text("더 이상 검색 결과가 없어요.")
            }
            
            GeometryReader { reader -> Color in
              let minY = reader.frame(in: .global).minY
              let height = UIScreen.main.bounds.height / 1.3
              if minY < height {
                DispatchQueue.main.async {
                  self.viewModel.fetchNextPage()
                }
              }
              
              return Color.clear
            }
            
          }
          
        } else {
          if viewModel.searchKeyword != "" {
            ProgressView()
              .padding(.top, 20)
          }
          
        }
        
      }
      .navigationTitle("IT 책 검색")
      
    }
    
  }
}

#Preview {
  SearchBooksView()
}
