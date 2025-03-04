//
//  SearchBookView.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//


import SwiftUI

struct SearchBookView: View {
    @ObservedObject var viewModel: BookViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Search Book")) {
                    TextField("Enter book title or genre", text: $viewModel.searchTitle)
                }
                
                Section {
                    Button("Search") {
                        viewModel.searchBook()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                }
                
                Section {
                    Button("Cancel") {
                        viewModel.searchTitle = ""
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Search Book")
            .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}
