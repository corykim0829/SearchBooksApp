import SwiftUI
import SearchBooksFeature
import BookmarkFeature

public struct SearchBooksAppView: View {
  public init() {}
  
  public var body: some View {
    TabView {
      SearchBooksFeatureView()
        .tabItem {
          Image(systemName: "doc.text.magnifyingglass")
          Text("책 검색")
        }
      BookmarkFeatureView()
        .tabItem {
          Image(systemName: "bookmark.fill")
          Text("북마크")
        }
    }
  }
}


struct SearchBooksAppView_Previews: PreviewProvider {
  static var previews: some View {
    SearchBooksAppView()
  }
}
