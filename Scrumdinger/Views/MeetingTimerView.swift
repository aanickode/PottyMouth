/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation
import RealmSwift
import AudioToolbox

struct MeetingTimerView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var count : Int = 0
    @State private var storedCount : Int = 0
    private var frequency: TimeInterval { 1.0 / 60.0 }
    let realm = try! Realm()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    
    var body: some View {
        VStack {
            Image("jar2").resizable()
                .scaledToFit().overlay{
                    VStack {
                        Text("Profanity Count")
                        Text("\(storedCount)")
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
        Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { timer in
            update()
        }
    }
    
    private func update() {
        count = speechRecognizer.profanityCount
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        let user = users.first
        storedCount = user?.totalScore ?? 0
        speechRecognizer.resetProfanity()
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
