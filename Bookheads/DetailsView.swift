//
//  DetailsView.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 26/06/21.
//

import SwiftUI
import CoreData

struct DetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    let book: Book
    
    var genre: String {
        self.book.genre ?? "Fantasy"
    }
    
    var headline: String {
        "\(book.title ?? "Unknown Title") by \(book.author ?? "Unknown Author")"
    }
    
    init(_ book: Book) {
        self.book = book
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    Text(self.book.genre ?? "Fantasy")
                        .font(.title)
                        .fontWeight(.black)
                        .bold()
                        .foregroundColor(.primary)
                        .colorInvert()
                        .padding()
                        .background(Color.primary.opacity(0.7))
                        .clipShape(Capsule())
                        .shadow(radius: 30)
                }
                HStack (alignment: .center){
                    Text("Author:")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                        .colorInvert()
                    Spacer()
                    Text(book.author ?? "Unknown Author")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                        .colorInvert()
                }
                .padding()
                .background(Color.primary.opacity(0.7))
                HStack (alignment: .center){
                    Text("Rating:")
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)
                        .colorInvert()
                    Spacer()
                    EmojiRatingView(rating: book.rating)
                        .scaleEffect(1.2)
                }
                .padding()
                .background(Color.primary.opacity(0.7))
                ScrollView () {
                    Text(book.review ?? "Unkown Review")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .colorInvert()
                        .padding()
                        .frame(maxWidth: geo.size.width, alignment: .leading)
                }.frame(maxWidth: geo.size.width)
                .background(Color.primary.opacity(0.7))
                .clipShape(Rectangle())
            }
        }
        .navigationBarTitle(book.title ?? "Unknown Title")
        .navigationBarItems(trailing:
            Button("Delete") {
                self.showingDeleteAlert.toggle()
            }
            .frame(maxWidth: .infinity)
            .font(.headline)
            .padding(.horizontal)
            .padding(3)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color(white: 0.2)]), startPoint: .top, endPoint: .bottom))
            .clipShape(Capsule())
            .foregroundColor(.white)
        )
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("🚨 Confirm"),
                  message: Text("Are you sure you want to delete this book review?"),
                  primaryButton: .destructive(Text("Confirm"), action: deleteBook),
                  secondaryButton: .cancel()
            )
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Test Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = """
            This is a test review with asdhjsahdjasdjasjdhasj dhasdjkashdjkhasjkdhakjdhjkashdk jahdkjahs kjdhaksjdhkja hdjkashdjkhasdjkhasjkdhkjasdhjkashdj ka shdjkhasjkdh jks dhjks dhasjkdhasjdkhasdkjashdjkhsjkdhjk sdhjkasdh
            
            
            
            
            It is padded to handle
            
            
            
            
            Scroll Features
            
            
            
            In the View
            """
        book.id = UUID()
        return NavigationView {
            DetailsView(book)
        }
    }
}
