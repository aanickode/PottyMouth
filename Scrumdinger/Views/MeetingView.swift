/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @State var analyticsShow = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            VStack {
                Button("Analytics"){
                    analyticsShow = true
                }
                MeetingTimerView()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        NavigationLink(destination: AnalyticsView(), isActive: $analyticsShow){
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
