//
//  SettingView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            List {
                Section("Username") {
                    TextField("isName", text: $userName)
                        .autocapitalization(.words)
                }
                
                Section("App Lock") {
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                            Toggle("Lock When App Goes Background", isOn: $lockWhenAppGoesBackground)
                    }
                }
            }
            .navigationTitle("Settings")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    SettingView()
}
