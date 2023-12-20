//
//  MainView.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI

struct MainView: View {
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            
            Button {
                showModal.toggle()
            } label: {
                TextHelper(text: "Open", color: .blue, fontSize: 18)
                    .padding()
            }.navigationTitle(Text(""))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        TextHelper(text: "Main", fontSize: 28)
                            .fontWeight(.semibold)
                    }
                }.sheet(isPresented: $showModal) {
                    Modal()
                }
        }
    }
}

#Preview {
    MainView()
}
