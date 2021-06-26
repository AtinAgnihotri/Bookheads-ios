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
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true),
    ]) var books: FetchedResults<Book>
    @State var showingAddScreen = false
    @State var rating = 3
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books, id:\.self) { book in
                        NavigationLink(destination: DetailsView(book)
                                        .environment(\.managedObjectContext, moc)) {
                            EmojiRatingView(rating: book.rating)
                            VStack (alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author ?? "Unknown Author")
                                    .font(.caption)
                                    .foregroundColor(book.rating == 1 ? .red : .secondary)
                            }
                        }
                    }.onDelete(perform: deleteBooks)
                }
            }
            .navigationBarTitle("Bookheads")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: showAddBookView,
                label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primary)
                        .colorInvert()
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.secondary, Color(white: 0.2)]), startPoint: .top, endPoint: .bottom))
                        .frame(alignment:.leading)
                        .scaleEffect(1.5)
                        .clipShape(Circle())
                        .scaleEffect(0.9)
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
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
