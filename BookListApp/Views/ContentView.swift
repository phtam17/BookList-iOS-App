//
//  ContentView.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BookViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)
                
                // Main Content
                VStack {
                    if let book = viewModel.currentBook {
                        BookDetailView(book: book)
                    } else {
                        VStack(spacing: 20) {
                            Text("Library Unavailable")
                                .font(.title)
                            Text("Please add your first book")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("BookList")
            .toolbar {
                // Top toolbar items
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showingAddBook = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showingDeleteBook = true
                    }) {
                        Image(systemName: "trash")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showingSearchBook = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                
                // Bottom toolbar items
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            viewModel.previousBook()
                        }) {
                            Image(systemName: "arrow.left")
                                .frame(width: 44, height: 44)
                        }
                        .disabled(viewModel.books.isEmpty)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.nextBook()
                        }) {
                            Image(systemName: "arrow.right")
                                .frame(width: 44, height: 44)
                        }
                        .disabled(viewModel.books.isEmpty)
                    }
                }
            }
            // Alert for various messages
            .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                Button("OK", role: .cancel) { }
            }
            // Sheet for adding a book
            .sheet(isPresented: $viewModel.showingAddBook) {
                AddBookView(viewModel: viewModel)
            }
            // Sheet for deleting a book
            .sheet(isPresented: $viewModel.showingDeleteBook) {
                DeleteBookView(viewModel: viewModel)
            }
            // Sheet for searching a book
            .sheet(isPresented: $viewModel.showingSearchBook) {
                SearchBookView(viewModel: viewModel)
            }
            // Sheet for editing a book
            .sheet(isPresented: $viewModel.showingEditBook) {
                EditBookView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
