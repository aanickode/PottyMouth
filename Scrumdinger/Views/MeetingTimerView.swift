/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingTimerView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var count : Int = 0
    private var frequency: TimeInterval { 1.0 / 60.0 }
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    
    var body: some View {
        VStack {
            Image("jar2").resizable()
                .scaledToFit().overlay{
                    VStack {
                        Text("Profanity Count")
                        Text("\(count)")
                    }
                }
        }
        .onAppear {
            startScrum()
            startTimer()
        }
        .onDisappear {
            endScrum()
        }
    }
    
    private func startTimer() {
        print("timer created")
        Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            update()
        }
    }
    
    private func update() {
        count = speechRecognizer.profanityCount
    }
    
    private func startScrum() {
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
    }
    
    private func endScrum() {
        speechRecognizer.stopTranscribing()
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    
    static var previews: some View {
        MeetingTimerView()
    }
}
