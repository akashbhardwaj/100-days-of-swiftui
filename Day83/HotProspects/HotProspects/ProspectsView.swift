//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-13.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
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
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Akash Bhardwaj\nbhardwaj@swift.com"){ handleScan(result: $0) }
            }
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
            prospects.people.append(prospect)
        case .failure(let failure):
            print("Scanning failed \(failure.localizedDescription)")
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
