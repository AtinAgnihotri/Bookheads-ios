//
//  CustomComponents.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 23/06/21.
//

import SwiftUI

struct PushButton: View {
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

struct CustomComponents: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var rememberMe = false
    var body: some View {
//        VStack {
//            PushButton(title: "Remember me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
        // AnyView help us do type erasure, although there is a performance impact, so it's best to avoid AnyView unless specifically needed
        if sizeClass == .compact {
            return AnyView(VStack {
                Text("Active Size Class:")
                Text("COMPACT")
            }.font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active Size Class:")
                Text("REGULAR")
            }.font(.largeTitle))
        }
    }
}

struct CustomComponents_Previews: PreviewProvider {
    static var previews: some View {
        CustomComponents()
    }
}
