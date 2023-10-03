//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Akash Bhardwaj on 2023-10-03.
//

import SwiftUI

class ActivitiesHelper: ObservableObject {
    @Published
    var activities: [Activity] = [] {
        didSet {
            saveActivities()
        }
    }

    init(activities: [Activity] = []) {
        self.activities = fetchData()
    }

    func saveActivities() {
        guard let data = try? JSONEncoder().encode(activities) else {
            fatalError("Could not encoded data")
        }
        UserDefaults.standard.setValue(data, forKey: "activities")
    }

    func fetchData() -> [Activity] {
        guard let data = UserDefaults.standard.data(forKey: "activities") else {
            return []
        }
        guard let activities = try? JSONDecoder().decode([Activity].self, from: data) else {
            return []
        }
        return activities
    }
}



struct Activity: Identifiable, Codable {
    let name: String
    let description: String
    let id: UUID
    var count: Int

    init(name: String, description: String, count: Int) {
        self.name = name
        self.description = description
        self.count = count
        self.id = UUID()
    }
}

struct ContentView: View {
    @ObservedObject var activitiesHelper = ActivitiesHelper()
    @State private var isAddingActivity = false

    var body: some View {
        NavigationView {
            List($activitiesHelper.activities) { activity in
                ActivityItemView(activity: activity)
            }
            .navigationTitle("Activity Tracker")
            .toolbar {
                Button("Add") {
                    isAddingActivity = true
                }
            }
            .sheet(isPresented: $isAddingActivity) {
                AddActivityView { activity in
                    add(activity: activity)
                }
            }
        }
    }

    func add(activity: Activity) {
        activitiesHelper.activities.append(activity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ActivityItemView: View {
    @Binding var activity: Activity

    var body: some View {
        NavigationLink {
            ActivityDetails(activity: $activity)
        } label: {
            VStack {
                Text(activity.name)
                    .font(.title2)
                Text(activity.description)
                    .font(.caption)
            }
        }
    }
}
