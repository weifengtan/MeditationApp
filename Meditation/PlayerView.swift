//
//  PlayerView.swift
//  Meditation
//
//  Created by Alan on 7/4/22.
//
// MEDITATION APP THAT USES AVKIT AND SWIFTUI

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var meditationVM: MeditationViewModel
    var isPreview: Bool = false 
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    let timer = Timer
        .publish(every: 0.01, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            // MARK: Blurview
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.0)
                .ignoresSafeArea()
            
            VStack(spacing: 32){
                // MARK: Dismiss Button
                
                HStack {
                    Button {
                        audioManager.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                // MARK: Title
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // MARK: Playback
                
                if let player = audioManager.player {
                    VStack(spacing: 5){
                        //MARK: Playback Timeline
                        
                        Slider(value: $value, in: 0...player.duration){
                            editing in
                            
                            print ("editing", editing)
                            isEditing = editing
                            
                            if !editing {
                                player.currentTime = value
                            }
                        }
                            .accentColor(.white)
                        
                        // MARK: Playback Time
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            
                            Spacer()
                            
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    
                    // MARK: Playback Controls
                    
                    HStack{
                        // MARK: Repeat Button
                        let  color: Color = audioManager.islooping ? .teal : .white
                        PlaybackControlButton(systemName: "repeat", color: color) {
                            audioManager.toggleloop()
                        }
                        
                        Spacer()
                        
                        // MARK: Backward Button
                        PlaybackControlButton(systemName: "gobackward.10") {
                            player.currentTime -= 10
                        }
                        
                        Spacer()
                        
                        // MARK: Play/Pause Button
                        PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                            audioManager.playPause()
                            
                        }
                        
                        Spacer()
                        
                        // MARK: Forward Button
                        PlaybackControlButton(systemName: "goforward.10") {
                            player.currentTime += 10
                        }
                        
                        Spacer()
                        
                        // MARK: Stop Button
                        PlaybackControlButton(systemName: "stop.fill") {
                            audioManager.stop()
                            dismiss()
                        }
                        
                    } // Hstack end
                }

            }
            .padding(20)
            .onAppear {
//                AudioManager.shared.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
                audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
            }
            .onReceive(timer) { _ in
                guard let player = audioManager.player, !isEditing else {return}
                value = player.currentTime
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    
    static var previews: some View {
        PlayerView(meditationVM: meditationVM, isPreview: true)
            .environmentObject(AudioManager())
    }
}
