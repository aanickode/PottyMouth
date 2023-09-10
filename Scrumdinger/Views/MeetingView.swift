/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @State var analyticsShow = false
    @State var logout = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            VStack {
                Button("Analytics"){
                    analyticsShow = true
                }
                MeetingTimerView()
                Button("Logout"){
                    logout = true
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        NavigationLink(destination: AnalyticsView(), isActive: $analyticsShow){
        }
        NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $logout){
        }.navigationBarBackButtonHidden(true)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
