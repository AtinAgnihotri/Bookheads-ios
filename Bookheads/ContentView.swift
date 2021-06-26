//
//  ContentView.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 23/06/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @State var showingAddScreen = false
    @State var rating = 3
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books, id:\.self) { book in
                        NavigationLink(destination: DetailsView(book)) {
                            EmojiRatingView(rating: book.rating)
                            VStack (alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Bookheads")
            .navigationBarItems(
                trailing: Button(action: showAddBookView,
                label: {
                    Image(systemName: "plus")
                }
            ))
        }
        .sheet(isPresented: $showingAddScreen) {
            AddBookView().environment(\.managedObjectContext, self.moc)
        }
    }
    
    func showAddBookView() {
        self.showingAddScreen.toggle()
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
