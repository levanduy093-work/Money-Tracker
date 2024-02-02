//
//  StatsMoneyTracker.swift
//  StatsMoneyTracker
//
//  Created by Lê Văn Duy on 02/02/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let entry = WidgetEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetEntry] = []
        
        entries.append(.init(date: .now))
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        completion(timeline)
    }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
}

struct StatsMoneyTrackerEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            FilterTransactionViewModel(startDate: .now.startOfMonth, endDate: .now.endOfMonth) { transactions in
                CardView(
                    income: total(transactions, category: .income),
                    expense: total(transactions, category: .expense)
                )
            }
        }
    }
}

struct StatsMoneyTracker: Widget {
    let kind: String = "StatsMoneyTracker"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            StatsMoneyTrackerEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: Transaction.self)
        }
        .supportedFamilies([.systemMedium, .systemLarge])
        .contentMarginsDisabled()
        .configurationDisplayName("Money Tracker")
        .description("See how many money you use in month.")
    }
}

#Preview(as: .systemSmall) {
    StatsMoneyTracker()
} timeline: {
    WidgetEntry(date: .now)
}
