//
//  DeviceDetailView.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI

public struct DeviceDetailView: View {
    @EnvironmentObject private var vm: DiagnosticsViewModel

    public var body: some View {
        NavigationStack {
            List {
                Section("Идентификация устройства") {
                    HStack {
                        Label("Коммерческое имя", systemImage: "iphone")
                        Spacer()
                        Text(vm.specs.marketingName)
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Кодовая модель", systemImage: "tag.fill")
                        Spacer()
                        Text(vm.hardwareIdentifier)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.orange)
                    }

                    HStack {
                        Label("Версия iOS", systemImage: "apple.logo")
                        Spacer()
                        Text(UIDevice.current.systemVersion)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Имя устройства", systemImage: "person.text.rectangle")
                        Spacer()
                        Text(UIDevice.current.name)
                            .foregroundColor(.gray)
                    }
                }

                Section("Экран и дисплей") {
                    HStack {
                        Label("Разрешение экрана", systemImage: "rectangle.inset.filled")
                        Spacer()
                        let bounds = UIScreen.main.nativeBounds
                        Text("\(Int(bounds.width)) × \(Int(bounds.height)) px")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Плотность пикселей (PPI)", systemImage: "viewfinder")
                        Spacer()
                        Text("\(vm.specs.ppi) ppi")
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Частота обновления экрана", systemImage: "speedometer")
                        Spacer()
                        Text("\(vm.specs.maxRefreshRate) Hz \(vm.specs.maxRefreshRate > 60 ? "(ProMotion)" : "")")
                            .foregroundColor(vm.specs.maxRefreshRate > 60 ? .green : .white)
                    }

                    HStack {
                        Label("Масштаб отображения", systemImage: "arrow.up.left.and.down.right.magnifyingglass")
                        Spacer()
                        Text("@\(Int(UIScreen.main.scale))x Retina")
                            .foregroundColor(.gray)
                    }
                }

                Section("О приложении VIDA16") {
                    HStack {
                        Label("Приложение", systemImage: "info.circle.fill")
                        Spacer()
                        Text("VIDA16 v1.0.0 (AIDA64 Edition)")
                            .foregroundColor(.orange)
                    }

                    HStack {
                        Label("Период обновления сенсоров", systemImage: "timer")
                        Spacer()
                        Text("1.5 секунды")
                            .foregroundColor(.green)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Устройство")
        }
    }
}
