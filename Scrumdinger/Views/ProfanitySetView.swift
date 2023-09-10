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
    let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("background").resizable()
                    .scaledToFill().edgesIgnoringSafeArea(.all)
                VStack(spacing: 15){
                    Spacer().frame(height: 10)
                    Text("Choose Your Profanity!")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    TextField("Input Word", text: $word)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background()
                        .cornerRadius(10)
                
                    HStack{
                        Button("Add"){
                            appendWord(word: word)
                        }
                        .foregroundColor(.white)
                        .frame(width: 140, height: 50)
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(10)
                        Button("Finish"){
                            completeSignUp()
                        }
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.blue.opacity(0.4))
                        .cornerRadius(10)
                    }
                    Spacer().frame(height: 15)
                    ForEach(profanityList, id: \.self) {word in
                        Text(word).foregroundColor(.white)
                    }
                    
                }
                NavigationLink(destination: MeetingView().navigationBarBackButtonHidden(true), isActive: $isFinished){
                }.navigationBarBackButtonHidden(true)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func appendWord(word: String) {
        if (!profanityList.contains(word)) {
            profanityList.append(word.lowercased())
        }
    }
    
    func completeSignUp() {
        isFinished = true
        let realm = try! Realm(configuration: configuration)
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            try! realm.write {
                for word in profanityList {
                    user.profanitySet.append(word)
                    user.freqMap[word] = 0
                }
            }
        }
    }
}

struct ProfanitySetView_Previews: PreviewProvider {
    static var previews: some View {
        ProfanitySetView()
    }
}
