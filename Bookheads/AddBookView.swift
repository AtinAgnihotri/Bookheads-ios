//
//  AddBookView.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 25/06/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry",  "Romance", "Thriller"]
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 2
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Title").font(.headline)) {
                        TextField("Title of the book", text: $title)
                    }
                    
                    Section(header: Text("Author").font(.headline)) {
                        TextField("Author of the book", text: $author)
                    }
                    
                    Section(header: Text("Genre").font(.headline)) {
                        Picker(selection: $genre, label: Text("Genre of the book")) {
                            ForEach(genres, id: \.self) { genre in
                                Text(genre)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                    }
                    
                    Section(header: Text("Rating").font(.headline)) {
                        StarRatingView(rating: $rating)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Section(header: Text("Review").font(.headline)) {
                        TextEditor(text: $review)
                    }
                    
                }
                
                Button("Save") {
                    submitBook()
                }
                .frame(maxWidth: .infinity)
                .font(.title)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color(white: 0.2)]), startPoint: .top, endPoint: .bottom))
                .clipShape(Capsule())
                .foregroundColor(.white)
                .padding(.horizontal)
                
            }.navigationBarTitle("Add Book", displayMode: .inline)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMsg = message
        showingAlert = true
    }
    
    func showErrorAlert(_ errorMessage: String) {
        showAlert(title: "⚠️ Error", message: errorMessage)
    }
    
    func submitBook() {
        guard !title.isEmpty else {
            showErrorAlert("Title of the book cannot be empty")
            return
        }
        
        guard !author.isEmpty else {
            showErrorAlert("Author of the book cannot be empty")
            return
        }
        
        print("Submit book started")
        saveBook()
        clearForm()
        self.presentationMode.wrappedValue.dismiss()
        print("Successfully saved book to local storage")
    }
    
    func saveBook() {
        let book = Book(context: self.moc)
        book.title = self.title
        book.author = self.author
        book.genre = self.genre
        book.id = UUID()
        book.date = Date()
        book.review = self.review
        book.rating = Int16(rating)
        try? self.moc.save()
    }
    
    func clearForm() {
        self.title = ""
        self.author = ""
        self.genre = ""
        self.review = ""
        self.rating = 2
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
