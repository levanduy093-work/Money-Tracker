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
    @State private var filterText: String = ""
    @State private var selectedCategory: Category? = nil
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    FilterTransactionViewModel(category: selectedCategory, searchText: searchText) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction, showCategory: true)
                            }
                        }
                    }
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
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
            })
        }
    }
    
    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
            Button {
                selectedCategory = nil
            } label: {
                HStack {
                    Text("Both")
                    
                    if selectedCategory == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button {
                    selectedCategory = category
                } label: {
                    HStack {
                        Text(category.rawValue)
                        
                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "slider.vertical.3")
        }

    }
}

#Preview {
    SearchView()
}
