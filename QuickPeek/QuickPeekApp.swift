//
//  QuickPeekApp.swift
//  QuickPeek
//
//  Created by 경민기 on 12/12/25.
//

import SwiftUI

@main
struct QuickPeekApp: App {
    @StateObject private var zipManager = ZipManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(zipManager)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification)) { _ in
                    zipManager.cleanupTempFiles()
                }
        }
    }
}
