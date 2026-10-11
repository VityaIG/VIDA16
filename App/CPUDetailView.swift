//
//  CPUDetailView.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI

public struct CPUDetailView: View {
    @EnvironmentObject private var vm: DiagnosticsViewModel

    public var body: some View {
        NavigationStack {
            List {
                // Thermal Temperature Hero Section
                Section {
                    VStack(spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("ТЕМПЕРАТУРА ПРОЦЕССОРА (SoC)")
                                    .font(.caption2.weight(.bold))
                                    .foregroundColor(.gray)
                                HStack(alignment: .firstTextBaseline, spacing: 8) {
                                    Text(String(format: "%.1f°C", vm.thermal.estimatedTempCelsius))
                                        .font(.system(size: 36, weight: .black, design: .monospaced))
                                        .foregroundColor(Color(hex: vm.thermal.colorHex))
                                    Text(String(format: "%.1f°F", vm.thermal.estimatedTempFahrenheit))
                                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                                        .foregroundColor(.orange)
                                }
                            }
                            Spacer()
                            Image(systemName: "flame.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(Color(hex: vm.thermal.colorHex))
                        }

                        Divider()

                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Термальное состояние")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text(vm.thermal.statusDescription)
                                    .font(.footnote.weight(.semibold))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("Статус троттлинга")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text(vm.thermal.isThrottling ? "АКТИВЕН ⚠️" : "ОТСУТСТВУЕТ ✅")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(vm.thermal.isThrottling ? .red : .green)
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }

                // Apple Silicon Architecture Section
                Section("Спецификации процессора") {
                    HStack {
                        Label("Модель процессора", systemImage: "cpu")
                        Spacer()
                        Text(vm.specs.socName)
                            .foregroundColor(.orange)
                    }

                    HStack {
                        Label("Всего ядер CPU", systemImage: "square.grid.2x2")
                        Spacer()
                        Text("\(vm.specs.cpuCores) ядер")
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Производительные (Performance)", systemImage: "bolt.badge.clock.fill")
                        Spacer()
                        Text("\(vm.specs.performanceCores) P-Cores")
                            .foregroundColor(.cyan)
                    }

                    HStack {
                        Label("Энергоэффективные (Efficiency)", systemImage: "leaf.fill")
                        Spacer()
                        Text("\(vm.specs.efficiencyCores) E-Cores")
                            .foregroundColor(.green)
                    }

                    HStack {
                        Label("Графические ядра (GPU)", systemImage: "display")
                        Spacer()
                        Text("\(vm.specs.gpuCores) Cores")
                            .foregroundColor(.purple)
                    }

                    HStack {
                        Label("Neural Engine (NPU)", systemImage: "brain.head.profile")
                        Spacer()
                        Text("\(vm.specs.neuralEngineTOPS) TOPS")
                            .foregroundColor(.pink)
                    }
                }

                // Live Core Usage Section
                Section("Загрузка ядер в реальном времени") {
                    ForEach(vm.cpuCores, id: \.coreIndex) { core in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Core #\(core.coreIndex + 1)")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.white)
                                Text(core.coreIndex < vm.specs.performanceCores ? "P-Core" : "E-Core")
                                    .font(.caption2.weight(.bold))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(core.coreIndex < vm.specs.performanceCores ? Color.cyan.opacity(0.2) : Color.green.opacity(0.2))
                                    .foregroundColor(core.coreIndex < vm.specs.performanceCores ? .cyan : .green)
                                    .cornerRadius(4)

                                Spacer()
                                Text("\(Int(core.usagePercent))%")
                                    .font(.system(.body, design: .monospaced).weight(.bold))
                                    .foregroundColor(.white)
                            }

                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(height: 6)
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(core.usagePercent > 80 ? Color.red : (core.usagePercent > 50 ? Color.orange : Color.cyan))
                                        .frame(width: geo.size.width * CGFloat(core.usagePercent) / 100.0, height: 6)
                                }
                            }
                            .frame(height: 6)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Процессор & Нагрев")
        }
    }
}
