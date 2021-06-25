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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Count: \(books.count)")
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
