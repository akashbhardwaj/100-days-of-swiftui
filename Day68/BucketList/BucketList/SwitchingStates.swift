//
//  SwitchingStates.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-17.
//

import SwiftUI
enum LoadingState {
    case loading, success, failed
}
struct LoadingView: View {
    var body: some View {
        Text("Loading..")
    }
}
struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}
struct FaildView: View {
    var body: some View {
        Text("Failed..")
    }
}
struct SwitchingStates: View {
    var loadingState = LoadingState.loading

    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FaildView()
        }
    }
}

#Preview {
    SwitchingStates()
}
