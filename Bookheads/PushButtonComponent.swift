//
//  PushButtonComponent.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 24/06/21.
//

import SwiftUI


struct PushButtonComponent: View {
    var title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(
                        gradient: Gradient(colors: isOn ? onColors : offColors),
                        startPoint: .top,
                        endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct PushButtonComponent_Previews: PreviewProvider {
    @State static var preview = true
    static var printTest: () -> () = {
        print("Test print")
    }
    static var buttonDisabled = false
    static var previews: some View {
        VStack {
            PushButtonComponent(title: "Test Button Previews Reviews", isOn: $preview)
        }
    }
}
