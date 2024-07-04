import SwiftUI
import SwiftUIIntrospect
import Domain

public struct SearchBooksFeatureView: View {
  
  public init() {}
  
  @StateObject var viewModel = SearchBooksViewModel()
  
  public var body: some View {
    
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
        
        if let books = viewModel.books {
          
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
            
            if viewModel.isFetchingNextPage {
              ProgressView()
            }
            
            if viewModel.hasNoNextPage {
              Text("더 이상 검색 결과가 없어요.")
            }
            
          }
          
        } else {
          if viewModel.searchKeyword != "" {
            ProgressView()
              .padding(.top, 20)
          }
          
        }
        
      }
      .introspect(.scrollView, on: .iOS(.v14, .v15, .v16, .v17), customize: { scrollView in
        scrollView.delegate = viewModel
      })
      .navigationTitle("IT 책 검색")
      .onReceive(NotificationCenter.default.publisher(for: .bookItemViewBookmarkButtonDidTap), perform: { notification in
        if let book = notification.userInfo?["book"] as? Book {
          viewModel.toggleSavedBook(book: book)
        }
      })
      .onAppear(perform: {
        viewModel.updateSavedBook()
      })
      
    }
    
  }
}


struct SearchBooksFeatureView_Previews: PreviewProvider {
  static var previews: some View {
    SearchBooksFeatureView()
  }
}
