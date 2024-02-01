//
//  Money_TrackerApp.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI

@main
struct Money_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
