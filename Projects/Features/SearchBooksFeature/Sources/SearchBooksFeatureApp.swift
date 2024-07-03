import SwiftUI

@main
struct SearchBooksFeatureApp: App {
  var body: some Scene {
    WindowGroup {
      SearchBooksFeatureView()
        .onAppear(perform: {
          print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        })
    }
  }
}
