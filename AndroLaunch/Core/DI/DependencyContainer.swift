//
//  DependencyContainer.swift
//  AndroLaunch
//
//  Created by Aman Raj on 21/4/25.
//
import Foundation
import Combine
 // Replace 'AndroLaunch' with your project's main module name

protocol DependencyContainerProtocol {
    var adbService: any ADBServiceProtocol { get }
    var scrcpyService: any ScrcpyServiceProtocol { get }
    var deviceRepository: any DeviceRepositoryProtocol { get }
    var menuViewModel: MenuViewModel { get }
}

final class DependencyContainer: DependencyContainerProtocol {
    static let shared = DependencyContainer()

    // MARK: - Private Properties
    private let adbServiceInstance: any ADBServiceProtocol
    private let scrcpyServiceInstance: any ScrcpyServiceProtocol
    private let deviceRepositoryInstance: any DeviceRepositoryProtocol
    private let menuViewModelInstance: MenuViewModel

    // MARK: - Initialization
    init(
        adbService: any ADBServiceProtocol = ADBService(),
        scrcpyService: any ScrcpyServiceProtocol = ScrcpyService()
    ) {
        self.adbServiceInstance = adbService
        self.scrcpyServiceInstance = scrcpyService
        self.deviceRepositoryInstance = DeviceRepository(
            adbService: adbService,
            scrcpyService: scrcpyService
        )
        self.menuViewModelInstance = MenuViewModel(
            deviceRepository: deviceRepositoryInstance
        )
    }

    // MARK: - Public Properties
    var adbService: any ADBServiceProtocol { adbServiceInstance }
    var scrcpyService: any ScrcpyServiceProtocol { scrcpyServiceInstance }
    var deviceRepository: any DeviceRepositoryProtocol { deviceRepositoryInstance }
    var menuViewModel: MenuViewModel { menuViewModelInstance }
}
