//
//  AnalyticsView.swift
//  Scrumdinger
//
//  Created by Akash Anickode on 9/10/23.
//

import SwiftUI
import RealmSwift



struct AnalyticsView: View {
    @State var words: [String] = []
    @State var frequencies: [Int] = []
    @State private var word = ""
    @State private var incorrectInfo = 0
    let realm = try! Realm()

    var body: some View {
        VStack{
            TextField("Add or delete words", text: $word)
                .padding()
                .frame(width: 300, height: 50)
                .border(.black)
                .foregroundColor(.black)
                .cornerRadius(10)
                .border(.red, width: CGFloat(incorrectInfo))
            HStack{
                Button("Add"){
                    addWord(word: word)
                }
                .foregroundColor(.black)
                .frame(width: 100, height: 25)
                .background(Color.blue)
                .cornerRadius(10)
                Button("Delete"){
                    deleteWord(word: word)
                }
                .foregroundColor(.black)
                .frame(width: 100, height: 25)
                .background(Color.blue)
                .cornerRadius(10)
            }
            Text("Frequency Counter")
            
            ForEach(0...words.count, id: \.self) {idx in
                if (idx != words.count) {
                    HStack(spacing: 10){
                        Text(words[idx])
                        Text("\(frequencies[idx])")
                    }
                }
            }
        }
        .onAppear(){
            self.loadFreq()
        }
    }
    
    func loadFreq() {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            words = user.freqMap.keys
            frequencies = user.freqMap.values
        }
    }
    
    func addWord(word : String) {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            if user.profanitySet.contains(word.lowercased()) {
                incorrectInfo = 2
            } else {
                incorrectInfo = 0
                try! realm.write {
                    user.profanitySet.append(word.lowercased())
                    user.freqMap[word.lowercased()] = 0
                }
            }
        }
        self.loadFreq()
    }
    
    func deleteWord(word : String) {
        let savedUsername = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        let savedPassword = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        let users = realm.objects(UserInfo.self).where{
            $0.password == savedPassword && $0.username == savedUsername
        }
        if let user = users.first {
            if user.profanitySet.contains(word.lowercased()) {
                incorrectInfo = 0
                var profanityCopy : [String] = []
                for profanity in user.profanitySet {
                    if profanity != word.lowercased() {
                        profanityCopy.append(profanity)
                    }
                }
                try! realm.write {
                    user.profanitySet.removeAll()
                    for copy in profanityCopy {
                        user.profanitySet.append(copy)
                    }
                    user.freqMap[word.lowercased()] = nil
                }
            } else {
                incorrectInfo = 2
            }
        }
        self.loadFreq()
    }

}

struct ListRow: View {
    var body: some View{
        HStack{
            Text("Person1")
            Spacer()
            Text("Bad Word")
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
