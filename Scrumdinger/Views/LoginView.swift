//
//  LoginView.swift
//  Scrumdinger
//
//  Created by Arnav Gattani on 9/9/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var incorrectInfo = 0
    @State private var showScreen = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack{
                    Text("Sign In")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background()
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(incorrectInfo))
                    VStack(spacing: 20){
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background()
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(incorrectInfo))
                        Button("Login"){
                            checkLogin(username: username, password: password)
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                    }
                    NavigationLink(destination: MeetingView(), isActive: $showScreen){
                    }
                }
            }
            .navigationBarHidden(true)
        }
        
    }
    
    func checkLogin(username: String, password: String){
        if (username == "Arnav"){
            incorrectInfo = 0
            if (password == "Gattani"){
                incorrectInfo = 0
                showScreen = true
            } else {
                incorrectInfo = 2
            }
        } else {
            incorrectInfo = 2
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
