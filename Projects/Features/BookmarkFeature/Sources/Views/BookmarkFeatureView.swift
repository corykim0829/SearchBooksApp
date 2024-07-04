import SwiftUI

public struct BookmarkFeatureView: View {
  
  public init() {}
  
  @StateObject var bookmarkBooksViewModel = BookmarkBooksViewModel()
  
  public var body: some View {
    
    NavigationView {
      ScrollView {
        if bookmarkBooksViewModel.books.count > 0 {
          LazyVStack {
            ForEach(bookmarkBooksViewModel.books, id: \.isbn13) { book in
              NavigationLink {
                Text(book.title)
              } label: {
                Text(book.title)
              }
            }
          }
        } else {
          Text("북마크한 책이 없어요.")
            .padding()
        }
        
      }
      .navigationTitle("북마크")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem {
          Menu {
            ForEach(BookmarkBooksViewModel.Sorting.allCases, id: \.title) { sorting in
              Button {
                bookmarkBooksViewModel.currentSorting = sorting
                bookmarkBooksViewModel.fetchAllBooks()
              } label: {
                if sorting == bookmarkBooksViewModel.currentSorting {
                  Label(sorting.title, systemImage: "checkmark")
                } else {
                  Text(sorting.title)
                }
                
              }
            }

          } label: {
            HStack {
              Image(systemName: "line.3.horizontal.decrease.circle")
              Text("정렬")
            }
          }
          
        }
      }
    }
    .onAppear {
      bookmarkBooksViewModel.fetchAllBooks()
    }
    
  }
}


struct BookmarkFeatureView_Previews: PreviewProvider {
  static var previews: some View {
    BookmarkFeatureView()
  }
}
