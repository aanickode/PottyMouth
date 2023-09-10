//
//  LoginView.swift
//  Scrumdinger
//
//  Created by Arnav Gattani on 9/9/23.
//

import SwiftUI
import RealmSwift

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var incorrectInfo = 0
    @State private var showScreen = false
    @State private var signInScreen = false
    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    let defaults = UserDefaults.standard
    
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
                        Button("Sign Up"){
                            signInScreen = true
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    NavigationLink(destination: MeetingView().navigationBarBackButtonHidden(true), isActive: $showScreen){
                    }.navigationBarBackButtonHidden(true)
                    NavigationLink(destination: SignInView(), isActive: $signInScreen){
                    }.navigationBarBackButtonHidden(true)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
    }
    
    func checkLogin(username: String, password: String){
        let realm = try! Realm(configuration: configuration)
        let users = realm.objects(UserInfo.self)
        let user = users.where{
            $0.password == password && $0.username == username
        }
        if user.isEmpty || username == "" || password == "" {
            incorrectInfo = 2
        } else {
            incorrectInfo = 0
            defaults.set(username, forKey: "username")
            defaults.set(password, forKey: "password")
            showScreen = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
