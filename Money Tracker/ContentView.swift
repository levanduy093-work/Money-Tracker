//
//  ContentView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false

    @State private var activeTab: Tab = .recents
    
    var body: some View {
        LockViewModel(lockType: .biometric, lockPin: "", isEnabled: isAppLockEnabled, lockWhenAppGoesBackground: lockWhenAppGoesBackground) {
            TabView(selection: $activeTab) {
                RecentView()
                    .tag(Tab.recents)
                    .tabItem { Tab.recents.tabContent }
                
                SearchView()
                    .tag(Tab.search)
                    .tabItem { Tab.search.tabContent }
                
                GraphView()
                    .tag(Tab.graphs)
                    .tabItem { Tab.graphs.tabContent }
                
                SettingView()
                    .tag(Tab.settings)
                    .tabItem { Tab.settings.tabContent }
            }
            .tint(appTint)
            .sheet(isPresented: $isFirstTime, content: {
                IntroView()
            })
        }
    }
}

#Preview {
    ContentView()
}
