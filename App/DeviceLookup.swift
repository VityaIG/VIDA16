//
//  DeviceLookup.swift
//  VIDA16
//
//  Полная база спецификаций устройств Apple (от iPhone 11/12 до 16 Pro Max).
//

import UIKit
import Darwin

public struct DeviceInfoLookup {
    public struct DeviceSpec {
        public let marketingName: String
        public let socName: String
        public let cpuCores: Int
        public let performanceCores: Int
        public let efficiencyCores: Int
        public let gpuCores: Int
        public let neuralEngineTOPS: Int
        public let nominalBatteryCapacityMah: Int
        public let ramTotalGB: Double
        public let ppi: Int
        public let maxRefreshRate: Int
    }

    public static func getHardwareIdentifier() -> String {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let identifier = String(cString: machine).trimmingCharacters(in: .whitespacesAndNewlines)
        return identifier.isEmpty ? "iPhone13,2" : identifier
    }

    public static func getSpecs(for identifier: String = getHardwareIdentifier()) -> DeviceSpec {
        switch identifier {
        // MARK: - iPhone 12 Series (A14 Bionic)
        case "iPhone13,2":
            return DeviceSpec(marketingName: "iPhone 12", socName: "Apple A14 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 11, nominalBatteryCapacityMah: 2815, ramTotalGB: 4.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone13,1":
            return DeviceSpec(marketingName: "iPhone 12 mini", socName: "Apple A14 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 11, nominalBatteryCapacityMah: 2227, ramTotalGB: 4.0, ppi: 476, maxRefreshRate: 60)
        case "iPhone13,3":
            return DeviceSpec(marketingName: "iPhone 12 Pro", socName: "Apple A14 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 11, nominalBatteryCapacityMah: 2815, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone13,4":
            return DeviceSpec(marketingName: "iPhone 12 Pro Max", socName: "Apple A14 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 11, nominalBatteryCapacityMah: 3687, ramTotalGB: 6.0, ppi: 458, maxRefreshRate: 60)

        // MARK: - iPhone 13 Series (A15 Bionic)
        case "iPhone14,5":
            return DeviceSpec(marketingName: "iPhone 13", socName: "Apple A15 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 3227, ramTotalGB: 4.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone14,4":
            return DeviceSpec(marketingName: "iPhone 13 mini", socName: "Apple A15 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 2406, ramTotalGB: 4.0, ppi: 476, maxRefreshRate: 60)
        case "iPhone14,2":
            return DeviceSpec(marketingName: "iPhone 13 Pro", socName: "Apple A15 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 3095, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 120)
        case "iPhone14,3":
            return DeviceSpec(marketingName: "iPhone 13 Pro Max", socName: "Apple A15 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 4352, ramTotalGB: 6.0, ppi: 458, maxRefreshRate: 120)

        // MARK: - iPhone 14 Series
        case "iPhone14,7":
            return DeviceSpec(marketingName: "iPhone 14", socName: "Apple A15 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 3279, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone14,8":
            return DeviceSpec(marketingName: "iPhone 14 Plus", socName: "Apple A15 Bionic (5nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 4325, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone15,2":
            return DeviceSpec(marketingName: "iPhone 14 Pro", socName: "Apple A16 Bionic (4nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 17, nominalBatteryCapacityMah: 3200, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 120)
        case "iPhone15,3":
            return DeviceSpec(marketingName: "iPhone 14 Pro Max", socName: "Apple A16 Bionic (4nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 17, nominalBatteryCapacityMah: 4323, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 120)

        // MARK: - iPhone 15 Series
        case "iPhone15,4":
            return DeviceSpec(marketingName: "iPhone 15", socName: "Apple A16 Bionic (4nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 17, nominalBatteryCapacityMah: 3349, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone15,5":
            return DeviceSpec(marketingName: "iPhone 15 Plus", socName: "Apple A16 Bionic (4nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 17, nominalBatteryCapacityMah: 4383, ramTotalGB: 6.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone16,1":
            return DeviceSpec(marketingName: "iPhone 15 Pro", socName: "Apple A17 Pro (3nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 6, neuralEngineTOPS: 35, nominalBatteryCapacityMah: 3274, ramTotalGB: 8.0, ppi: 460, maxRefreshRate: 120)
        case "iPhone16,2":
            return DeviceSpec(marketingName: "iPhone 15 Pro Max", socName: "Apple A17 Pro (3nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 6, neuralEngineTOPS: 35, nominalBatteryCapacityMah: 4422, ramTotalGB: 8.0, ppi: 460, maxRefreshRate: 120)

        // MARK: - iPhone 16 Series
        case "iPhone17,3":
            return DeviceSpec(marketingName: "iPhone 16", socName: "Apple A18 (3nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 35, nominalBatteryCapacityMah: 3561, ramTotalGB: 8.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone17,4":
            return DeviceSpec(marketingName: "iPhone 16 Plus", socName: "Apple A18 (3nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 5, neuralEngineTOPS: 35, nominalBatteryCapacityMah: 4674, ramTotalGB: 8.0, ppi: 460, maxRefreshRate: 60)
        case "iPhone17,1":
            return DeviceSpec(marketingName: "iPhone 16 Pro", socName: "Apple A18 Pro (3nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 6, neuralEngineTOPS: 35, nominalBatteryCapacityMah: 3582, ramTotalGB: 8.0, ppi: 460, maxRefreshRate: 120)
        case "iPhone17,2":
            return DeviceSpec(marketingName: "iPhone 16 Pro Max", socName: "Apple A18 Pro (3nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 6, neuralEngineTOPS: 35, nominalBatteryCapacityMah: 4685, ramTotalGB: 8.0, ppi: 460, maxRefreshRate: 120)

        // MARK: - iPhone 11 Series
        case "iPhone12,1":
            return DeviceSpec(marketingName: "iPhone 11", socName: "Apple A13 Bionic (7nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 8, nominalBatteryCapacityMah: 3110, ramTotalGB: 4.0, ppi: 326, maxRefreshRate: 60)
        case "iPhone12,3":
            return DeviceSpec(marketingName: "iPhone 11 Pro", socName: "Apple A13 Bionic (7nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 8, nominalBatteryCapacityMah: 3046, ramTotalGB: 4.0, ppi: 458, maxRefreshRate: 60)
        case "iPhone12,5":
            return DeviceSpec(marketingName: "iPhone 11 Pro Max", socName: "Apple A13 Bionic (7nm)", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 8, nominalBatteryCapacityMah: 3969, ramTotalGB: 4.0, ppi: 458, maxRefreshRate: 60)

        // MARK: - iPhone SE Series
        case "iPhone12,8":
            return DeviceSpec(marketingName: "iPhone SE (2nd gen)", socName: "Apple A13 Bionic", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 8, nominalBatteryCapacityMah: 1821, ramTotalGB: 3.0, ppi: 326, maxRefreshRate: 60)
        case "iPhone14,6":
            return DeviceSpec(marketingName: "iPhone SE (3rd gen)", socName: "Apple A15 Bionic", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 15, nominalBatteryCapacityMah: 2018, ramTotalGB: 4.0, ppi: 326, maxRefreshRate: 60)

        // MARK: - iPhone XR / XS
        case "iPhone11,8":
            return DeviceSpec(marketingName: "iPhone XR", socName: "Apple A12 Bionic", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 5, nominalBatteryCapacityMah: 2942, ramTotalGB: 3.0, ppi: 326, maxRefreshRate: 60)
        case "iPhone11,2":
            return DeviceSpec(marketingName: "iPhone XS", socName: "Apple A12 Bionic", cpuCores: 6, performanceCores: 2, efficiencyCores: 4, gpuCores: 4, neuralEngineTOPS: 5, nominalBatteryCapacityMah: 2658, ramTotalGB: 4.0, ppi: 458, maxRefreshRate: 60)

        default:
            // Универсальный fallback: если модель не найдена, определяем iPhone 12 как стандарт
            let isProMotion = UIScreen.main.maximumFramesPerSecond > 60
            let totalRam = Double(ProcessInfo.processInfo.physicalMemory) / (1024 * 1024 * 1024)
            return DeviceSpec(
                marketingName: UIDevice.current.name.contains("iPhone") ? UIDevice.current.name : "Apple iPhone (iOS Device)",
                socName: "Apple A14 Bionic",
                cpuCores: ProcessInfo.processInfo.processorCount,
                performanceCores: 2,
                efficiencyCores: max(2, ProcessInfo.processInfo.processorCount - 2),
                gpuCores: 4,
                neuralEngineTOPS: 11,
                nominalBatteryCapacityMah: 2815, // iPhone 12 default baseline
                ramTotalGB: totalRam > 1.0 ? totalRam : 4.0,
                ppi: 460,
                maxRefreshRate: isProMotion ? 120 : 60
            )
        }
    }
}
