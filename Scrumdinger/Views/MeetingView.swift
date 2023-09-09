/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            VStack {
                MeetingTimerView()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
