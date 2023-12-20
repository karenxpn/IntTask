//
//  ContentView.swift
//  LegitmarkTask
//
//  Created by Karen Mirakyan on 20.12.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("token") private var token = ""

    var body: some View {
        if token.isEmpty {
            Authentication()
        } else {
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
