//
//  RatingView.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-18.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    let label = ""
    let maximumRating = 5
    let offImage: Image?
    let onImage = Image(systemName: "star.fill")
    let offColor = Color.gray
    let onColor = Color.yellow

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) {  number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
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

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(5), offImage: nil)
    }
}
