//
//  BookheadsApp.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 23/06/21.
//

import SwiftUI

@main
struct BookheadsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
