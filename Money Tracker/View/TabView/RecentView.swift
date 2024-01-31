//
//  RecentView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI

struct RecentView: View {
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack {
                        Section {
                            
                        } header: {
                            HeaderView(size)
                        }
                    }
                }
                .background(.gray.opacity(0.15))
            }
        }
    }
    
    // Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        
    }
}

#Preview {
    ContentView()
}
