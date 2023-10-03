//
//  ActivityDetails.swift
//  ActivityTracker
//
//  Created by Akash Bhardwaj on 2023-10-03.
//

import SwiftUI

struct ActivityDetails: View {
    @Binding var activity: Activity

    var body: some View {
        VStack {
            Spacer()
            Text(activity.name)
                .multilineTextAlignment(.center)
                .font(.title)

            Text(activity.description)
                .multilineTextAlignment(.leading)

            Stepper("\(activity.count)", value: $activity.count)
            Spacer()
            Spacer()
        }
        .padding(20)

    }
}

struct ActivityDetails_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetails(activity: .constant(Activity(name: "Running", description: "Moving your legs fast", count: 0)))
    }
}
