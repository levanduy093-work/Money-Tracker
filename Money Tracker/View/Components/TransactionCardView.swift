//
//  TransactionCardView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 01/02/2024.
//

import SwiftUI

struct TransactionCardView: View {
    var transaction: Transaction
    var showCategory: Bool = true
    var body: some View {
        SwipeActionModel(cornerRadius: 10, direction: .trailing) {
            HStack {
                Text("\(String(transaction.title.prefix(1)))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color, in: .circle)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(transaction.title)
                        .foregroundStyle(Color.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(Color.primary.secondary)
                    
                    Text(format(date: transaction.dateAdded, format: "dd MMM yy"))
                        .font(.caption2)
                        .foregroundStyle(Color.primary.secondary)
                    
                    if showCategory {
                        Text(transaction.category)
                            .font(.caption2)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background(transaction.category == Category.income.rawValue ? .green : .red, in: .rect(cornerRadius: 10))
                    }
                })
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text("\(currencyString(transaction.amount, allowedDigits: 1))")
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                // Delete Transaction Card View:: Later
                
            }
        }
    }
}

#Preview {
    TransactionCardView(transaction: sampleTransactions[1])
}
