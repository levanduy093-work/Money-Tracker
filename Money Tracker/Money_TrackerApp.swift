//
//  Money_TrackerApp.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI
import WidgetKit

@main
struct Money_TrackerApp: App {
    @Environment(\.scenePhase) private var phase
    @State private var reloadWidgetWhenAppGoesBackground: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    WidgetCenter.shared.reloadAllTimelines()
                }
                .onChange(of: phase) { oldValue, newValue in
                    if newValue != .active && reloadWidgetWhenAppGoesBackground {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
        }
        .modelContainer(for: [Transaction.self])
    }
}
