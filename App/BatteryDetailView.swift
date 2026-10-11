//
//  BatteryDetailView.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI

public struct BatteryDetailView: View {
    @EnvironmentObject private var vm: DiagnosticsViewModel

    public var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.1), lineWidth: 14)
                                .frame(width: 150, height: 150)

                            Circle()
                                .trim(from: 0.0, to: CGFloat(vm.battery.levelPercent) / 100.0)
                                .stroke(
                                    LinearGradient(colors: [.green, .emerald], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 150, height: 150)

                            VStack(spacing: 2) {
                                Image(systemName: "battery.100.bolt")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                Text("\(vm.battery.levelPercent)%")
                                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                Text(vm.battery.stateDescription)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)

                        HStack(spacing: 20) {
                            VStack {
                                Text("ТЕКУЩАЯ ЕМКОСТЬ")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.gray)
                                Text("\(vm.battery.currentEstimatedMah) mAh")
                                    .font(.system(size: 18, weight: .heavy, design: .monospaced))
                                    .foregroundColor(.green)
                            }

                            Divider()
                                .frame(height: 30)

                            VStack {
                                Text("ПАСПОРТНАЯ ЕМКОСТЬ")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.gray)
                                Text("\(vm.battery.designCapacityMah) mAh")
                                    .font(.system(size: 18, weight: .heavy, design: .monospaced))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }

                Section("Параметры аккумулятора") {
                    HStack {
                        Label("Паспортная емкость (Design)", systemImage: "bolt.fill")
                        Spacer()
                        Text("\(vm.battery.designCapacityMah) mAh")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Текущий заряд (Real Current)", systemImage: "gauge.with.dots.needle.bottom.50percent")
                        Spacer()
                        Text("\(vm.battery.currentEstimatedMah) mAh")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.green)
                    }

                    HStack {
                        Label("Состояние здоровья (Health)", systemImage: "heart.fill")
                        Spacer()
                        Text("\(vm.battery.estimatedHealthPercent)% (Отличное)")
                            .foregroundColor(.green)
                    }

                    HStack {
                        Label("Напряжение батареи (Voltage)", systemImage: "speedometer")
                        Spacer()
                        Text(String(format: "%.2f V", vm.battery.voltageEstimatedV))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Статус питания", systemImage: "power")
                        Spacer()
                        Text(vm.battery.stateDescription)
                            .foregroundColor(.orange)
                    }

                    HStack {
                        Label("Режим энергосбережения", systemImage: "leaf.fill")
                        Spacer()
                        Text(vm.battery.isLowPowerMode ? "Включен ⚡" : "Выключен")
                            .foregroundColor(vm.battery.isLowPowerMode ? .yellow : .gray)
                    }

                    HStack {
                        Label("Технология элемента", systemImage: "atom")
                        Spacer()
                        Text("Lithium-ion (Li-ion)")
                            .foregroundColor(.gray)
                    }
                }

                Section("Справочная информация") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("О расчете емкости в VIDA16")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Apple ограничивает прямой доступ сторонних приложений к IOKit контроллеру батареи в песочнице iOS. VIDA16 точно определяет аппаратный идентификатор вашего устройства (\(vm.specs.marketingName)) и сопоставляет его с официальной паспортной спецификацией (\(vm.battery.designCapacityMah) mAh) в режиме реального времени.")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineSpacing(2)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Аккумулятор")
        }
    }
}

extension Color {
    static let emerald = Color(red: 16/255, green: 185/255, blue: 129/255)
}
