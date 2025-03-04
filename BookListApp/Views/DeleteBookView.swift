//
//  DeleteBookView.swift
//  BookListApp
//
//  Created by Tâm Phạm  on 3/3/25.
//


import SwiftUI

struct DeleteBookView: View {
    @ObservedObject var viewModel: BookViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Delete Book")) {
                    TextField("Enter book title to delete", text: $viewModel.deleteTitle)
                }
                
                Section {
                    Button("Delete Book") {
                        viewModel.deleteBook()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.red)
                }
                
                Section {
                    Button("Cancel") {
                        viewModel.deleteTitle = ""
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Delete Book")
            .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                Button("OK", role: .cancel) {
                    if viewModel.alertMessage == "Book successfully deleted" {
                        dismiss()
                    }
                }
            }
        }
    }
}
