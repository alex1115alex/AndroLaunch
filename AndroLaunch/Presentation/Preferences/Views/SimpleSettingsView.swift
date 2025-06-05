import SwiftUI
import ServiceManagement

struct SimpleSettingsView: View {
    @State private var launchAtLogin: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Add some top spacing
            Spacer()
                .frame(height: 30)
            
            // Header
            HStack {
                Image(systemName: "square.grid.2x2.fill")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundColor(.accentColor)
                VStack(alignment: .leading, spacing: 2) {
                    Text("AndroLaunch")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Android Device Management")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.bottom, 8)
            
            Divider()
            
            // Settings Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Preferences")
                    .font(.headline)
                
                // Launch at Login Toggle
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Launch at Login")
                            .font(.body)
                        Text("Automatically start AndroLaunch when you log in")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Toggle("", isOn: $launchAtLogin)
                        .onChange(of: launchAtLogin) { newValue in
                            setLaunchAtLogin(enabled: newValue)
                        }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.controlBackgroundColor))
                .cornerRadius(8)
            }
            
            Divider()
            
            // About Section
            VStack(alignment: .leading, spacing: 16) {
                Text("About")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("A professional macOS menu bar application for managing Android devices through ADB and Scrcpy.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Button(action: openGitHub) {
                        HStack {
                            Image(systemName: "globe")
                            Text("View on GitHub")
                        }
                    }
                    .buttonStyle(.link)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.controlBackgroundColor))
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(24)
        .frame(width: 420, height: 380)
        .onAppear {
            checkLaunchAtLoginStatus()
        }
    }
    
    private func checkLaunchAtLoginStatus() {
        let status = SMAppService.mainApp.status
        launchAtLogin = status == .enabled
        print("🚀 Launch at login status checked: \(status) -> toggle: \(launchAtLogin)")
    }
    
    private func setLaunchAtLogin(enabled: Bool) {
        print("🚀 Attempting to \(enabled ? "enable" : "disable") launch at login...")
        do {
            if enabled {
                try SMAppService.mainApp.register()
                print("🚀 Successfully registered for launch at login")
            } else {
                try SMAppService.mainApp.unregister()
                print("🚀 Successfully unregistered from launch at login")
            }
            
            // Verify the change took effect
            let newStatus = SMAppService.mainApp.status
            print("🚀 New launch at login status: \(newStatus)")
            
        } catch {
            print("❌ Failed to \(enabled ? "enable" : "disable") launch at login: \(error)")
            // Revert the toggle if the operation failed
            DispatchQueue.main.async {
                let currentStatus = SMAppService.mainApp.status
                launchAtLogin = currentStatus == .enabled
                print("🚀 Reverted toggle to: \(launchAtLogin) (status: \(currentStatus))")
            }
        }
    }
    
    private func openGitHub() {
        if let url = URL(string: "https://github.com/alex1115alex/AndroLaunch") {
            NSWorkspace.shared.open(url)
        }
    }
}