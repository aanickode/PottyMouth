//
//  SignInView.swift
//  Scrumdinger
//
//  Created by Akash Anickode on 9/9/23.
//

import SwiftUI
import RealmSwift

struct SignInView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var incorrectInfo = 0
    @State private var signUpComplete = false
    let realm = try! Realm()
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack{
                    Text("Sign Up")
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
                        Button("Sign Up"){
                            checkLogin(username: username, password: password)
                        }
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                    }
                    NavigationLink(destination: MeetingView(), isActive: $signUpComplete){
                    }
                }
            }
            .navigationBarHidden(true)
        }
        
    }
    func checkLogin(username: String, password: String){
        let users = realm.objects(UserInfo.self)
        let user = users.where{
            $0.password == password && $0.username == username
        }
        if user.isEmpty && password != "" && username != "" {
            incorrectInfo = 0
            let user = UserInfo()
            user.username = username
            user.password = password
            realm.beginWrite()
            realm.add(user)
            try! realm.commitWrite()
            defaults.set(username, forKey: "username")
            defaults.set(password, forKey: "password")
            signUpComplete = true
        } else {
            incorrectInfo = 2
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
