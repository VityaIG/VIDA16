//
//  MemoryDetailView.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI

public struct MemoryDetailView: View {
    @EnvironmentObject private var vm: DiagnosticsViewModel

    public var body: some View {
        NavigationStack {
            List {
                Section("Оперативная память (RAM)") {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Всего RAM: \(String(format: "%.1f GB", vm.memory.totalGB))")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(Int(vm.memory.usagePercentage))% Занято")
                                .font(.subheadline.weight(.bold))
                                .foregroundColor(.blue)
                        }

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(height: 12)
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geo.size.width * CGFloat(vm.memory.usagePercentage) / 100.0, height: 12)
                            }
                        }
                        .frame(height: 12)
                    }
                    .padding(.vertical, 4)

                    HStack {
                        Label("Активная память (Active)", systemImage: "bolt.fill")
                        Spacer()
                        Text(String(format: "%.2f GB", vm.memory.activeGB))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.blue)
                    }

                    HStack {
                        Label("Системная память (Wired)", systemImage: "lock.fill")
                        Spacer()
                        Text(String(format: "%.2f GB", vm.memory.wiredGB))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.purple)
                    }

                    HStack {
                        Label("Неактивная память (Inactive)", systemImage: "clock.arrow.circlepath")
                        Spacer()
                        Text(String(format: "%.2f GB", vm.memory.inactiveGB))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Label("Свободная память (Free)", systemImage: "checkmark.circle.fill")
                        Spacer()
                        Text(String(format: "%.2f GB", vm.memory.freeGB))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.green)
                    }
                }

                Section("Встроенный накопитель (NAND Storage)") {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Общий объем: \(String(format: "%.0f GB", vm.storage.totalGB))")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(Int(vm.storage.usagePercentage))% Занято")
                                .font(.subheadline.weight(.bold))
                                .foregroundColor(.purple)
                        }

                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white.opacity(0.1))
                                    .frame(height: 12)
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.purple)
                                    .frame(width: geo.size.width * CGFloat(vm.storage.usagePercentage) / 100.0, height: 12)
                            }
                        }
                        .frame(height: 12)
                    }
                    .padding(.vertical, 4)

                    HStack {
                        Label("Использовано", systemImage: "internaldrive.fill")
                        Spacer()
                        Text(String(format: "%.1f GB", vm.storage.usedGB))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Label("Доступно (Свободно)", systemImage: "folder.badge.plus")
                        Spacer()
                        Text(String(format: "%.1f GB", vm.storage.freeGB))
                            .foregroundColor(.green)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Память и Диск")
        }
    }
}
