//
//  BookDetailView.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//


import SwiftUI

struct BookDetailView: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Title: \(book.title)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Author: \(book.author)")
                .font(.title2)
            
            Text("Genre: \(book.genre)")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("Price: $\(String(format: "%.2f", book.price))")
                .font(.title3)
                .foregroundColor(.blue)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
    }
}
