//
//  Book.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//

import Foundation

struct Book: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var author: String
    var genre: String
    var price: Double
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.id == rhs.id
    }
}
