//
//  RecentView.swift
//  Money Tracker
//
//  Created by Lê Văn Duy on 31/01/2024.
//

import SwiftUI

struct RecentView: View {
    @AppStorage("userName") private var userName: String = ""
    @State private var showFilterView: Bool = false
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack {
                        Section {
                            // Date filter button
                            Button(action: {
                                showFilterView = true
                            }, label: {
                                Text("\(format(date: startDate, format: "dd - MMM yy")) to \(format(date: endDate, format: "dd - MMM yy"))")
                                    .foregroundStyle(.gray)
                                    .font(.caption2)
                            })
                            .hSpacing(.leading)
                        } header: {
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate) { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    } onClose: {
                        showFilterView = false
                    }
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    
    // Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10, content: {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            })
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint, in: .circle)
                    .contentShape(.circle)
            }
        })
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(size, proxy: geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        let process = minY / screenHeight
        let scale = min(max(process, 0), 1) * 0.4
        
        return 1 + scale
    }
    
    func headerBGOpacity(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
}

#Preview {
    ContentView()
}
