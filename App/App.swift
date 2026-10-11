//
//  App.swift
//  VIDA16 - Hardware & System Monitor
//
//  AIDA64-style real-time hardware diagnostics for iOS.
//

import SwiftUI

@main
struct VIDA16App: App {
    @StateObject private var vm = DiagnosticsViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(vm)
                .preferredColorScheme(.dark)
        }
    }
}
