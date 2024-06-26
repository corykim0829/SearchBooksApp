//
//  BookDetailView.swift
//  SearchBooks
//
//  Created by Cory Kim on 6/13/24.
//

import SwiftUI

struct BookDetailView: View {
  
  var book: Book
  
  @StateObject var bookDetailViewModel : BookDetailViewModel
  @State private var isShowingPDFWebView = false
  
  init(book: Book) {
    self.book = book
    self._bookDetailViewModel = StateObject(wrappedValue: BookDetailViewModel(book: book))
  }
  
  var body: some View {
    ScrollView(.vertical) {
        VStack {
          if let detailData = bookDetailViewModel.detailData {
            ImageView(urlString: detailData.image)
            .frame(height: 500)
            
            VStack(alignment: .leading, spacing: 8) {
              Text(detailData.title)
                .font(.system(size: 18, weight: .semibold))
              Text("작가: \(detailData.authors)")
              Text("가격: \(detailData.price)")
              Text("출판사: \(detailData.publisher)")
              Text(detailData.desc)
                .font(.system(size: 14, weight: .regular))
              
              if let pdf = detailData.pdf {
                Text("PDF")
                  .font(.system(size: 18, weight: .semibold))
                  .padding(.top, 20)
                LazyVStack(spacing: 8) {
                  ForEach(pdf.sorted(by: <), id: \.key) { key, value in
                    BookDetailPDFItemView(
                      title: key,
                      url: value,
                      isShowingPDFWebView: $isShowingPDFWebView)
                    .sheet(isPresented: $isShowingPDFWebView, onDismiss: {
                      isShowingPDFWebView = false
                    }, content: {
                      PDFWebView(url: value, isShowingPDFWebView: $isShowingPDFWebView)
                    })
                    
                  }
                  
                }
              }
              
            }
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            
          } else {
            ProgressView()
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .offset(y: -60)
      
    }
//    .sheet(isPresented: $isShowingPDFWebView) {
//      Text("TEST")
//    }
    
  }
  
}

#Preview {
  let book = Book(title: "TEST", subtitle: "test", isbn13: "123", price: "", image: "", url: "")
  return BookDetailView(book: book)
}
