//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-13.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortType {
        case alphabetically, chronologically
    }

    let filter: FilterType
    @State private var sortType = SortType.chronologically
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingConfirmation = false

    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspects) { prospect in
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAddress)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            isContactedIndicator(for: prospect)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect: prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect: prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.badge.checkmark")
                            }
                            .tint(.green)

                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }

                Button {
                    isShowingConfirmation = true
                } label: {
                    Label("Sort", systemImage: sortType == .alphabetically
                          ? "square.stack.3d.up.badge.automatic.fill"
                          : "square.stack.3d.up.badge.automatic")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Akash Bhardwaj\nakash@swift.com"){ handleScan(result: $0) }
            }
            .confirmationDialog("Sort", isPresented: $isShowingConfirmation) {
                Button("Alphabetically") {
                    sortType = .alphabetically
                }
                Button("Most Recent") {
                    sortType = .chronologically
                }
            }
        }
    }

    @ViewBuilder
    func isContactedIndicator(for prospect: Prospect) -> (some View)? {
        if filter == .none && prospect.isContacted {
            Image(systemName: "person.crop.circle.badge.checkmark")
        }
    }

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }

    var sortedProspects: [Prospect] {
        switch sortType {
        case .alphabetically:
            filteredProspects.sorted(by: { $0.name < $1.name })
        case .chronologically:
            filteredProspects.sorted(by: { $0.dateCreated > $1.dateCreated })
        }
    }

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            prospects.people
        case .contacted:
            prospects.people.filter { $0.isContacted }
        case .uncontacted:
            prospects.people.filter { !$0.isContacted }
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let results):
            let details = results.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let prospect = Prospect()
            prospect.name = details[0]
            prospect.emailAddress = details[1]
            prospects.add(prospect)
        case .failure(let failure):
            print("Scanning failed \(failure.localizedDescription)")
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = prospect.name
            content.subtitle = prospect.emailAddress
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 9

            #if DEBUG
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            #else
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            #endif

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, errror in
                    if success {
                        addRequest()
                    } else {
                        print("Error")
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
