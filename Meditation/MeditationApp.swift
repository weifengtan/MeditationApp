//
//  MeditationApp.swift
//  Meditation
//
//  Created by Alan on 7/3/22.
//

import SwiftUI

@main
struct MeditationApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
