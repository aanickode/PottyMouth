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
            Image("background").resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 2){
                MeetingTimerView()
                HStack {
                    Button("Analytics"){
                        analyticsShow = true
                    }.foregroundColor(.white)
                        .frame(width: 130, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    Button("Logout"){
                        logout = true
                    }.foregroundColor(.white)
                        .frame(width: 130, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        NavigationLink(destination: AnalyticsView(), isActive: $analyticsShow){
        }.navigationBarBackButtonHidden(true)
        NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $logout){
        }.navigationBarBackButtonHidden(true)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
