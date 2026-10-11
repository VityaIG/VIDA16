//
//  DashboardView.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI

public struct DashboardView: View {
    @EnvironmentObject private var vm: DiagnosticsViewModel

    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Header Banner
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(vm.specs.marketingName)
                                .font(.title2.weight(.bold))
                                .foregroundColor(.white)
                            Text(vm.specs.socName)
                                .font(.subheadline)
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                Text("ONLINE")
                                    .font(.caption2.weight(.bold))
                                    .foregroundColor(.green)
                            }
                            Text("1.5s refresh")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(16)

                    // Top 2 Highlights: Real Battery Capacity & CPU Thermal Temp
                    HStack(spacing: 12) {
                        // Real Battery Capacity Card
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "battery.100.bolt")
                                    .foregroundColor(.green)
                                Text("АККУМУЛЯТОР")
                                    .font(.caption2.weight(.bold))
                                    .foregroundColor(.gray)
                            }

                            Text("\(vm.battery.currentEstimatedMah) mAh")
                                .font(.system(size: 24, weight: .black, design: .monospaced))
                                .foregroundColor(.white)

                            HStack {
                                Text("\(vm.battery.levelPercent)%")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.green)
                                Spacer()
                                Text("из \(vm.battery.designCapacityMah) mAh")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }

                            // Progress bar
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(height: 6)
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.green)
                                        .frame(width: geo.size.width * CGFloat(vm.battery.levelPercent) / 100.0, height: 6)
                                }
                            }
                            .frame(height: 6)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(16)

                        // CPU Temperature / Thermal Card
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.orange)
                                Text("ТЕМПЕРАТУРА CPU")
                                    .font(.caption2.weight(.bold))
                                    .foregroundColor(.gray)
                            }

                            Text(String(format: "%.1f°C", vm.thermal.estimatedTempCelsius))
                                .font(.system(size: 24, weight: .black, design: .monospaced))
                                .foregroundColor(Color(hex: vm.thermal.colorHex))

                            HStack {
                                Text(String(format: "%.1f°F", vm.thermal.estimatedTempFahrenheit))
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.orange)
                                Spacer()
                                Text(vm.thermal.isThrottling ? "Троттлинг!" : "В норме")
                                    .font(.caption2.weight(.bold))
                                    .foregroundColor(vm.thermal.isThrottling ? .red : .green)
                            }

                            Text(vm.thermal.statusDescription)
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(16)
                    }

                    // RAM Usage Bar
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "memorychip")
                                .foregroundColor(.blue)
                            Text("ОПЕРАТИВНАЯ ПАМЯТЬ (RAM)")
                                .font(.caption2.weight(.bold))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "%.1f / %.1f GB", vm.memory.usedGB, vm.memory.totalGB))
                                .font(.caption.weight(.semibold))
                                .foregroundColor(.white)
                        }

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(height: 10)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geo.size.width * CGFloat(vm.memory.usagePercentage) / 100.0, height: 10)
                            }
                        }
                        .frame(height: 10)

                        HStack {
                            Text("Занято: \(Int(vm.memory.usagePercentage))%")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Свободно: \(String(format: "%.2f GB", vm.memory.freeGB))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(16)

                    // CPU Per-Core Load Bars
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "cpu")
                                .foregroundColor(.cyan)
                            Text("ЗАГРУЗКА ЯДЕР ПРОЦЕССОРА (\(vm.specs.cpuCores) ЯДЕР)")
                                .font(.caption2.weight(.bold))
                                .foregroundColor(.gray)
                        }

                        ForEach(vm.cpuCores, id: \.coreIndex) { core in
                            HStack(spacing: 8) {
                                Text("Ядро #\(core.coreIndex + 1)")
                                    .font(.caption.weight(.medium))
                                    .frame(width: 60, alignment: .leading)
                                    .foregroundColor(.gray)

                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 3)
                                            .fill(Color.white.opacity(0.1))
                                            .frame(height: 8)
                                        RoundedRectangle(cornerRadius: 3)
                                            .fill(core.usagePercent > 75 ? Color.red : (core.usagePercent > 45 ? Color.orange : Color.cyan))
                                            .frame(width: geo.size.width * CGFloat(core.usagePercent) / 100.0, height: 8)
                                    }
                                }
                                .frame(height: 8)

                                Text("\(Int(core.usagePercent))%")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.white)
                                    .frame(width: 38, alignment: .trailing)
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(16)

                    // Storage summary
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "internaldrive")
                                .foregroundColor(.purple)
                            Text("ВСТРОЕННЫЙ НАКОПИТЕЛЬ (NAND)")
                                .font(.caption2.weight(.bold))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "%.0f GB", vm.storage.totalGB))
                                .font(.caption.weight(.semibold))
                                .foregroundColor(.white)
                        }

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(height: 8)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.purple)
                                    .frame(width: geo.size.width * CGFloat(vm.storage.usagePercentage) / 100.0, height: 8)
                            }
                        }
                        .frame(height: 8)

                        HStack {
                            Text("Использовано: \(String(format: "%.1f GB", vm.storage.usedGB))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Свободно: \(String(format: "%.1f GB", vm.storage.freeGB))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(16)
                }
                .padding()
            }
            .background(Color.black)
            .navigationTitle("VIDA16")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.refresh()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.orange)
                    }
                }
            }
        }
    }
}

// Color extension helper for Hex codes
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
