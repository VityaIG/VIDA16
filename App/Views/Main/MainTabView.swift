//
//  MainTabView.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab: Int = 0

    public var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Сводка", systemImage: "gauge.with.dots.needle.bottom.50percent")
                }
                .tag(0)

            BatteryDetailView()
                .tabItem {
                    Label("Батарея", systemImage: "battery.100.bolt")
                }
                .tag(1)

            CPUDetailView()
                .tabItem {
                    Label("CPU/Нагрев", systemImage: "flame.fill")
                }
                .tag(2)

            MemoryDetailView()
                .tabItem {
                    Label("Память", systemImage: "memorychip")
                }
                .tag(3)

            DeviceDetailView()
                .tabItem {
                    Label("Устройство", systemImage: "iphone")
                }
                .tag(4)
        }
        .tint(.orange)
    }
}
