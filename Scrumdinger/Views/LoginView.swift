//
//  LoginView.swift
//  Scrumdinger
//
//  Created by Arnav Gattani on 9/9/23.
//

import SwiftUI
<<<<<<< HEAD
=======
import RealmSwift
>>>>>>> b5ee9ab (Database changes)

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var incorrectInfo = 0
    @State private var showScreen = false
<<<<<<< HEAD
=======
    @State private var signInScreen = false
    let realm = try! Realm()
    let defaults = UserDefaults.standard
    
>>>>>>> b5ee9ab (Database changes)
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
<<<<<<< HEAD
=======
                        Button("Sign Up"){
                            signInScreen = true
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
>>>>>>> b5ee9ab (Database changes)
                        
                    }
                    NavigationLink(destination: MeetingView(), isActive: $showScreen){
                    }
<<<<<<< HEAD
=======
                    NavigationLink(destination: SignInView(), isActive: $signInScreen){
                    }
>>>>>>> b5ee9ab (Database changes)
                }
            }
            .navigationBarHidden(true)
        }
        
    }
    
    func checkLogin(username: String, password: String){
<<<<<<< HEAD
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
=======
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
>>>>>>> b5ee9ab (Database changes)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
