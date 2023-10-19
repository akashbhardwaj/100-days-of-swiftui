//
//  ContentView.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-17.
//

import SwiftUI
struct ContentView: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title, order: .reverse),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetails(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen, content: {
                AddBookView()
            })
            .navigationTitle("Bookworm")
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            context.delete(book)
        }

        try? context.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
