//
//  ProfanitySetView.swift
//  Scrumdinger
//
//  Created by Akash Anickode on 9/9/23.
//

import SwiftUI
import RealmSwift

struct ProfanitySetView: View {
    
    @State var profanityList: [String] = []
    @State var counter = 0
    @State var word : String = ""
    @State var isFinished = false
    let realm = try! Realm()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Text("Choose Your Profanity!")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    TextField("Word", text: $word)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background()
                        .cornerRadius(10)
                    Button("Add"){
                        appendWord(word: word)
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    ForEach(profanityList, id: \.self) {word in
                        Text(word).foregroundColor(.white)
                    }
                    Button("Finish"){
                        completeSignUp()
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                NavigationLink(destination: MeetingView(), isActive: $isFinished){
                }
            }
        }
    }
    
    func appendWord(word: String) {
        if (!profanityList.contains(word)) {
            profanityList.append(word.lowercased())
        }
    }
    
    func completeSignUp() {
        isFinished = true
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            print(user.profanitySet)
            try! realm.write {
                for word in profanityList {
                    user.profanitySet.append(word)
                }
            }
            print(user.profanitySet)
        }
        if let user = users.first {
            print("second")
            print(user.profanitySet)
        }
    }
}

struct ProfanitySetView_Previews: PreviewProvider {
    static var previews: some View {
        ProfanitySetView()
    }
}
