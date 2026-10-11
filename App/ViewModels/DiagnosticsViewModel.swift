//
//  DiagnosticsViewModel.swift
//  VIDA16
//
//  Created for VIDA16 Hardware Monitor.
//

import SwiftUI
import Combine

@MainActor
public final class DiagnosticsViewModel: ObservableObject {
    @Published public var battery: SystemDiagnosticsService.BatteryInfo
    @Published public var thermal: SystemDiagnosticsService.ThermalInfo
    @Published public var memory: SystemDiagnosticsService.MemoryInfo
    @Published public var storage: SystemDiagnosticsService.StorageInfo
    @Published public var cpuCores: [SystemDiagnosticsService.CPUCoreLoad]
    @Published public var specs: DeviceInfoLookup.DeviceSpec
    @Published public var hardwareIdentifier: String
    @Published public var lastUpdated: Date = Date()
    @Published public var isMonitoring: Bool = true

    private var cancellables = Set<AnyCancellable>()
    private let service = SystemDiagnosticsService.shared

    public init() {
        UIDevice.current.isBatteryMonitoringEnabled = true

        self.battery = service.getBatteryInfo()
        self.thermal = service.getThermalInfo()
        self.memory = service.getMemoryInfo()
        self.storage = service.getStorageInfo()
        self.cpuCores = service.getCPUCoresLoad()
        self.specs = DeviceInfoLookup.getSpecs()
        self.hardwareIdentifier = DeviceInfoLookup.getHardwareIdentifier()

        setupNotifications()
        startTelemetryTimer()
    }

    private func setupNotifications() {
        // Мгновенная реакция на изменение уровня заряда батареи
        NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.refresh() }
            .store(in: &cancellables)

        // Реакция на подключение/отключение кабеля зарядки
        NotificationCenter.default.publisher(for: UIDevice.batteryStateDidChangeNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.refresh() }
            .store(in: &cancellables)

        // Реакция на изменение температуры процессора
        NotificationCenter.default.publisher(for: ProcessInfo.thermalStateDidChangeNotification)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.refresh() }
            .store(in: &cancellables)
    }

    public func refresh() {
        self.battery = service.getBatteryInfo()
        self.thermal = service.getThermalInfo()
        self.memory = service.getMemoryInfo()
        self.storage = service.getStorageInfo()
        self.cpuCores = service.getCPUCoresLoad()
        self.lastUpdated = Date()
    }

    public func startTelemetryTimer() {
        Timer.publish(every: 1.5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.isMonitoring else { return }
                self.refresh()
            }
            .store(in: &cancellables)
    }

    public func stopTelemetryTimer() {
        cancellables.removeAll()
    }

    deinit {
        cancellables.removeAll()
    }
}
