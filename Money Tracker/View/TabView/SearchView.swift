//
//  SearchView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var filterText : String = ""
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.1), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
            })
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .overlay {
                ContentUnavailableView("Search Transaction", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            }
        }
    }
}

#Preview {
    ContentView()
}
