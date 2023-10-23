//
//  AddBookView.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-18.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    @State private var isShowingAlert = false

    let genres = ["Fantasy",  "Horror", "Kids", "Mystery", "Poetry",  "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author of Bool", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)

                    RatingView(rating: $rating, offImage: nil)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        saveBook()
                    }
                }
            }
            .alert("Invalid Input", isPresented: $isShowingAlert) {
                Button("Ok") {

                }
            } message: {
                Text("Please fill in all details")
            }
            .navigationTitle("Add Book")
        }
    }

    func saveBook () {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            isShowingAlert = true
            return
        }
        let newBook = Book(context: context)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.review = review
        newBook.dateAdded = Date.now

        try? context.save()
        dismiss()

    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
