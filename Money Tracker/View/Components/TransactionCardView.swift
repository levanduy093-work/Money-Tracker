//
//  TransactionCardView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 01/02/2024.
//

import SwiftUI

struct TransactionCardView: View {
    var transaction: Transaction
    var body: some View {
        SwipeActionModel(cornerRadius: 10, direction: .trailing) {
            
        } actions: {
            Action(tint: .red, icon: "trash") {
                // Delete
            }
        }

    }
}

#Preview {
    TransactionCardView(transaction: sampleTransactions[1])
}
