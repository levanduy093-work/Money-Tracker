//
//  DateFilterView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> ()
    var onClose: () -> ()
    
    var body: some View {
        VStack(spacing: 15) {
            DatePicker("Start Date", selection: $start, displayedComponents: [.date])
            
            DatePicker("End Date", selection: $end, displayedComponents: [.date])
            
            HStack(spacing: 15, content: {
                Button(action: {
                    onClose()
                }, label: {
                    Text("Cancel")
                        .frame(width: 60)
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(.red)
                
                Button(action: {
                    onSubmit(start, end)
                }, label: {
                    Text("Filter")
                        .frame(width: 60)
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 5))
                .tint(appTint)
            })
            .padding(.top, 10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal, 30)
    }
}

#Preview(body: {
    ContentView()
})

