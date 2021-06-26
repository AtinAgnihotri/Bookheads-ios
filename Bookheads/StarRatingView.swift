//
//  StarRatingView.swift
//  Bookheads
//
//  Created by Atin Agnihotri on 25/06/21.
//

import SwiftUI

struct StarRatingView: View {
//    var label = "Rating"
    @Binding var rating: Int
    var label = ""
    let maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1..<maxRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
                    .padding(.horizontal)
            }
        }
 
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    
    static var previews: some View {
        StarRatingView(rating: .constant(4))
    }
}
