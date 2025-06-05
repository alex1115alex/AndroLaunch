//
//  AppDelegate.swift
//  AndroLaunch
//
//  Created by Aman Raj on 21/4/25.
//

import SwiftUI
import ServiceManagement
import UserNotifications

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusMenuController: StatusMenuController?
    private var settingsWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        let container = DependencyContainer.shared
        statusMenuController = StatusMenuController(viewModel: container.menuViewModel, appDelegate: self)
        
        // Request notification permissions
        requestNotificationPermissions()
    }
    
    private func requestNotificationPermissions() {
        if #available(macOS 10.14, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        print("✅ Notification permissions granted")
                    } else if let error = error {
                        print("❌ Notification permissions denied: \(error.localizedDescription)")
                    } else {
                        print("❌ Notification permissions denied")
                    }
                }
            }
        }
    }

    func openPreferences() {
        print("📱 Opening preferences window...")
        
        if let existingWindow = settingsWindow {
            print("📱 Reusing existing window")
            existingWindow.orderFront(nil)
            existingWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        
        print("📱 Creating new settings window")
        let settingsView = SimpleSettingsView()
        let hostingController = NSHostingController(rootView: settingsView)
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 420, height: 380),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.contentViewController = hostingController
        window.title = "AndroLaunch Settings"
        window.center()
        window.setFrameAutosaveName("AndroLaunchSettings")
        window.isReleasedWhenClosed = false
        window.level = .floating
        
        settingsWindow = window
        
        // Ensure the app can show windows
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
        
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        
        print("📱 Settings window should be visible now")
        
        // Reset back to accessory mode after a brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NSApp.setActivationPolicy(.accessory)
        }
    }
}
