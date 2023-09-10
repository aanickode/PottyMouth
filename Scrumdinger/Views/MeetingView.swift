/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @State var analyticsShow = false
    @State var logout = false
    @State private var savedUsername = ""
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            Image("background").resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 2){
                Text("\(savedUsername)'s SwearJar").font(.system(size: 20))
                    .foregroundColor(.white)
                    .bold()
                MeetingTimerView()
                HStack {
                    Button("Analytics"){
                        analyticsShow = true
                    }.foregroundColor(.white)
                        .frame(width: 130, height: 50)
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(10)
                    Button("Logout"){
                        logout = true
                    }.foregroundColor(.white)
                        .frame(width: 130, height: 50)
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(10)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        NavigationLink(destination: AnalyticsView(), isActive: $analyticsShow){
        }.navigationBarBackButtonHidden(true)
        NavigationLink(destination: LoginView().navigationBarBackButtonHidden(true), isActive: $logout){
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                loadFreq()
            }
    }
    
    func loadFreq() {
        savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
    }
    
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
