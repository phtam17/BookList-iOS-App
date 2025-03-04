//
//  BookViewModel.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//


import Foundation
import SwiftUI

class BookViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var books: [Book] = []
    @Published var currentBookIndex: Int = 0
    @Published var showingAddBook = false
    @Published var showingDeleteBook = false
    @Published var showingSearchBook = false
    @Published var showingEditBook = false
    @Published var searchResults: Book?
    @Published var alertMessage = ""
    @Published var showingAlert = false
    
    // MARK: - Temporary properties for adding/editing
    @Published var newTitle = ""
    @Published var newAuthor = ""
    @Published var newGenre = ""
    @Published var newPrice = ""
    
    // Search property
    @Published var searchTitle = ""
    @Published var deleteTitle = ""
    
    // MARK: - Initialization
    init() {
        // Load sample data for testing
        loadSampleData()
    }
    
    // MARK: - Sample data
    private func loadSampleData() {
        books = [
            Book(title: "The Echoes of Eternity", author: "Sophie Wilson", genre: "Fantasy/Adventure", price: 19.99),
            Book(title: "Beneath a Fractured Sky", author: "Nathan Lee Osborn", genre: "Science Fiction", price: 24.99),
            Book(title: "Whispers in the Willow", author: "Emily Richards", genre: "Mystery/Thriller", price: 17.99),
            Book(title: "Threads of a Forgotten World", author: "Maya Davis", genre: "Historical Fiction", price: 22.99)
        ]
    }
    
    // MARK: - Methods for Book Management
    
    // Add a new book
    func addBook() {
        guard !newTitle.isEmpty, !newAuthor.isEmpty, !newGenre.isEmpty, !newPrice.isEmpty else {
            alertMessage = "Please fill all fields"
            showingAlert = true
            return
        }
        
        guard let price = Double(newPrice) else {
            alertMessage = "Price must be a valid number"
            showingAlert = true
            return
        }
        
        let newBook = Book(title: newTitle, author: newAuthor, genre: newGenre, price: price)
        books.append(newBook)
        
        // Reset form fields
        resetFormFields()
        showingAddBook = false
    }
    
    // Delete a book
    func deleteBook() {
        guard !deleteTitle.isEmpty else {
            alertMessage = "Please enter a book title"
            showingAlert = true
            return
        }
        
        if let index = books.firstIndex(where: { $0.title.lowercased() == deleteTitle.lowercased() }) {
            books.remove(at: index)
            if currentBookIndex >= books.count && currentBookIndex > 0 {
                currentBookIndex -= 1
            }
            alertMessage = "Book successfully deleted"
            showingAlert = true
            deleteTitle = ""
            showingDeleteBook = false
        } else {
            alertMessage = "Book not found"
            showingAlert = true
        }
    }
    
    // Search for a book
    func searchBook() {
        guard !searchTitle.isEmpty else {
            alertMessage = "Please enter a book title or genre"
            showingAlert = true
            return
        }
        
        if let book = books.first(where: { 
            $0.title.lowercased().contains(searchTitle.lowercased()) || 
            $0.genre.lowercased().contains(searchTitle.lowercased())
        }) {
            searchResults = book
            showingSearchBook = false
            showingEditBook = true
            
            // Populate edit fields
            newTitle = book.title
            newAuthor = book.author
            newGenre = book.genre
            newPrice = String(format: "%.2f", book.price)
        } else {
            alertMessage = "No books found"
            showingAlert = true
        }
    }
    
    // Update a book after editing
    func updateBook() {
        guard let searchResults = searchResults else {
            return
        }
        
        guard !newTitle.isEmpty, !newAuthor.isEmpty, !newGenre.isEmpty, !newPrice.isEmpty else {
            alertMessage = "Please fill all fields"
            showingAlert = true
            return
        }
        
        guard let price = Double(newPrice) else {
            alertMessage = "Price must be a valid number"
            showingAlert = true
            return
        }
        
        if let index = books.firstIndex(where: { $0.id == searchResults.id }) {
            books[index].title = newTitle
            books[index].author = newAuthor
            books[index].genre = newGenre
            books[index].price = price
            
            alertMessage = "Book updated successfully"
            showingAlert = true
            
            // Reset form fields
            resetFormFields()
            self.searchResults = nil
            showingEditBook = false
        }
    }
    
    // Reset form fields
    func resetFormFields() {
        newTitle = ""
        newAuthor = ""
        newGenre = ""
        newPrice = ""
        searchTitle = ""
        deleteTitle = ""
    }
    
    // Navigation methods
    func nextBook() {
        if currentBookIndex < books.count - 1 {
            currentBookIndex += 1
        } else {
            alertMessage = "You've reached the end of your collection"
            showingAlert = true
        }
    }
    
    func previousBook() {
        if currentBookIndex > 0 {
            currentBookIndex -= 1
        } else {
            alertMessage = "You're at the beginning of your collection"
            showingAlert = true
        }
    }
    
    // Get current book if available
    var currentBook: Book? {
        guard !books.isEmpty else { return nil }
        return books[currentBookIndex]
    }
}