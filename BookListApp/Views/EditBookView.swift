//
//  EditBookView.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//


import SwiftUI

struct EditBookView: View {
    @ObservedObject var viewModel: BookViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Book")) {
                    TextField("Title", text: $viewModel.newTitle)
                    TextField("Author", text: $viewModel.newAuthor)
                    TextField("Genre", text: $viewModel.newGenre)
                    TextField("Price", text: $viewModel.newPrice)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Update Book") {
                        viewModel.updateBook()
                        if viewModel.alertMessage == "Book updated successfully" {
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                }
                
                Section {
                    Button("Cancel") {
                        viewModel.resetFormFields()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Book")
            .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}
