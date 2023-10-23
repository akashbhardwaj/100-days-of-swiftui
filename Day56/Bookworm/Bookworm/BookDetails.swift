//
//  BookDetails.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-19.
//

import SwiftUI

struct BookDetails: View {
    let book: Book

    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var isShowingAlert = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASy")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)

            }

            Text(book.author ?? "unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            if let addedDate = book.dateAdded {
                Text(addedDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.accentColor)
            }

            Text(book.review ?? "No Review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)), offImage: nil)
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Book?", isPresented: $isShowingAlert) {
            Button("Delete", role: .destructive) {
                deleteBook()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                isShowingAlert = true
            } label: {
                Label("Delete Book", systemImage: "trash")
            }
        }

    }

    func deleteBook() {
        context.delete(book)
        try? context.save()
        dismiss()
    }
}

